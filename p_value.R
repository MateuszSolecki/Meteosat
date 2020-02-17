poczatek = Sys.time()

# wczytuje kolejno pliki wejsciowe
for (k in 80:84) {
dane = read.table(paste0("D:/mateusz/wyniki_1_stopien/statystyki2/r1_",k,".txt"), header=FALSE)
wym = dim(dane)
start_time = Sys.time()

tabela = 1:(wym[1]*5)
dim(tabela) = c(wym[1],5)

#for (a in 1:length(dane$V1) ) {
for (a in 1:wym[1]) {

print(paste('liczy warstwe:', k, ' wektor:', a, 'z 64800'))

	wektor = dane[a,4:ncol(dane)] 
	wektor = wektor[wektor >=0 ] 

if (length(unique(wektor)) > 1) {
	test = t.test(wektor)

	tabela[a,1] = dane[a,1]
	tabela[a,2] = dane[a,2]
	tabela[a,3] = dane[a,3]
	tabela[a,4] = test[[5]]
	tabela[a,5] = test[[3]]

	} else if (length(unique(wektor)) > 0 & length(unique(wektor)) < 2) {
	test = 99
	tabela[a,1] = dane[a,1]
	tabela[a,2] = dane[a,2]
	tabela[a,3] = dane[a,3]
	tabela[a,4] = mean(wektor)
	tabela[a,5] = 99

	} else {
	test = 99
	tabela[a,1] = dane[a,1]
	tabela[a,2] = dane[a,2]
	tabela[a,3] = dane[a,3]
	tabela[a,4] = 99
	tabela[a,5] = 99
}
	
	tabela[a,5][is.na(tabela[a,5])] = 99
	if (tabela[a,5]<=0.001) {tabela[a,5]=0.001}

} # a

write.table(tabela, file=paste("D:/mateusz/wyniki_1_stopien/p_value/p_",k,".txt"), row.names=FALSE, col.names=FALSE, sep= " ")

end_time = Sys.time()
print(end_time - start_time)

} # k
koniec = Sys.time()
print(koniec-poczatek)
print('koniec')

