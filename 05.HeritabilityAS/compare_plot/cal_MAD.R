args<-commandArgs(T)
PSI_infile <- args[1]
print(PSI_infile)
datapsi <- read.table(PSI_infile, header=T, row.names=1)
datapsi <- datapsi[order(row.names(datapsi)),]
datapsi$MAD <- apply(datapsi,1,mad)
datamad <- datapsi[c("MAD")]
head(datamad)
write.table(datamad, file="original_MAD.txt", sep=" ", quote=F, col.names=F)

