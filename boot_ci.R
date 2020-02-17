library(boot)
dane = read.table("//glass/lira/mateusz/wyniki_zachmurzenie111.txt", header=FALSE)

poczatek = Sys.time()

tabela = 1:453600
dim(tabela) = c(64800,7)

#for (a in 1:length(dane$V1) ) {
for (a in 1:10) {
#	start_time = Sys.time() # kiedy zaczynamy obliczenia
print(paste('liczy', a, 'z 10'))
	wektor = dane[a,4:ncol(dane)] # zawezamy dane; pomijamy pierwsze trzy kolumny
	wektor = wektor[wektor >=0 ] # pomijamy braki obserwacji kodowane jako '-1'

	IleProfili = length(wektor >=0) # ile elementow w wektorze spelnia wymog? 

	if (IleProfili > 0) { # jesli wektor zeroelementowy to nie rob nic, inaczej: policz boot

			boot_mean <- function(original_vector, resample_vector) { # definicja funkcji dla boot
			mean(original_vector[resample_vector])}

		start_time = Sys.time()
			mean_results = boot(wektor, boot_mean, R = 10000,parallel="multicore", ncpus = getOption("boot.ncpus", 1L)  ) # policz srednia / boot
			srednia = mean_results[[1]] #wybierz wartosc, ktora nas interesuje
		
			boot_CI = boot.ci(mean_results, conf=0.95, parallel="multicore", ncpus = getOption("boot.ncpus", 1L), type=c("basic", "norm", "perc")) # polich przedzial ufnosci
			przedzial_ufnosci_basic = (boot_CI[[5]][5] - boot_CI[[5]][4])/2 # wybierz wartosc, ktora nas interesuje
			przedzial_ufnosci_norm = (boot_CI[[4]][3] - boot_CI[[4]][2])/2
			przedzial_ufnosci_perc = (boot_CI[[6]][5] - boot_CI[[6]][4])/2

		end_time = Sys.time() # kiedy kończymy obliczenia
		
		print(end_time - start_time) # ile trwało obliczanie

	tabela[,1] = dane[,1]
	tabela[,2] = dane[,2]
	tabela[,3] = dane[,3]
	tabela[a,4] = srednia
	tabela[a,5] = przedzial_ufnosci_basic
	tabela[a,6] = przedzial_ufnosci_norm
	tabela[a,7] = przedzial_ufnosci_perc
	
	koniec = Sys.time()
	print(koniec-poczatek)

			

#	end_time = Sys.time() # kiedy kończymy obliczenia
#	print(end_time - start_time) # ile trwało obliczanie
}
}

write.table(tabela, file="//glass/lira/mateusz/boot_ci_095.txt", row.names=FALSE, col.names=FALSE, sep= " ")