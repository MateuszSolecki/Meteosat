dane = read.table("//glass/lira/mateusz/boot_ci_095.txt")

poczatek = Sys.time()

y = dane[,1]
x = dane[,2] 
h = dane[,3]
srednia = dane[,4]
CI = dane[,6]

tabela = 1:64800
dim(tabela) = c(18,36,100)

for (z in 1:64800) {
tabela[(x[z]+1),(y[z]+1),(h[z]+1)] = srednia[z]
}

writeTIFF(tabela, "//glass/lira/mateusz/boot_mean_norm_3d.tif", bits.per.sample = 8L)

writeTIFF(tabela, getwd())



koniec = Sys.time()
print(koniec-poczatek)


