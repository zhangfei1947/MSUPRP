library(matrixStats)
library(moments)
library(dplyr)

args = commandArgs(T)
wkpath = args[1]
sexfile = args[2]
setwd(wkpath)
gene_tmp_file = "all_gene_tpm.txt"
gene_list = "remain_gene.list"

genetpm = read.table(gene_tmp_file,header=TRUE,row.names=1)
genelist = as.vector(unlist(read.table(gene_list)))
genetpm = genetpm[genelist,]
genetpm_mat = as.matrix(genetpm)
#genetpm_mat[genetpm_mat==0] = NA

#sex_dat = read.table(sexfile,head=T,row.names=1)
#sex_dat = t(sex_dat)
#sex_dat = sex_dat[,names(data)]

if(!dir.exists("gene_tpm_distri")){dir.create("gene_tpm_distri")}
setwd("gene_tpm_distri")
genetpm$Var = rowVars(genetpm_mat,na.rm=TRUE)
genetpm$log2Var = log2(genetpm$Var)
genetpm$MAD = rowMads(genetpm_mat,na.rm=TRUE)
genetpm$log2MAD = log2(genetpm$MAD+0.001)
genetpm$CV = sqrt(genetpm$Var/rowMeans(genetpm_mat,na.rm=TRUE))
genetpm$span = rowMaxs(genetpm_mat,na.rm=T)-rowMins(genetpm_mat,na.rm=T)
sk <- function(line){skewness(line[1:143],na.rm=TRUE)}
genetpm$skewness = apply(genetpm_mat, 1, sk)

## plot log2Var log2MAD skewness
png("genetpm.log2Var.hist.png")
hist(genetpm$log2Var)
dev.off()
png("genetpm.log2MAD.hist.png")
hist(genetpm$log2MAD)
dev.off()
png("genetpm.CV.hist.png")
hist(genetpm$CV)
dev.off()
png("genetpm.CV.0_15.hist.png")
hist(genetpm$CV[genetpm$CV<15],breaks=30)
dev.off()
png("genetpm.CV.0_5.hist.png")
hist(genetpm$CV[genetpm$CV<5],breaks=30)
dev.off()
png("genetpm.skewness.hist.png")
hist(genetpm$skewness)
dev.off()

genetpm$skewness = abs(genetpm$skewness)

for(i in c(0.4)){
	genetpm_p = filter(genetpm,CV<(i+0.1) & CV>(i-0.1))
#	ii = sprintf("%02d", i)
	ii = i
	p = genetpm_p[sample(nrow(genetpm_p),10),]
	for(j in 1:10){
		d = p[j,]
		png(paste0("CV.",ii,".",j,".gene.tpm.png"),width=600,height=500,units="px")
		hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="gene tpm",main=paste0("CV=",round(d[1,"CV"],4)," lgMAD=",round(d[1,"log2MAD"],4)," skewness=",round(d[1,"skewness"],4)))
		dev.off()
	}
	p = genetpm_p[order(genetpm_p[,"log2MAD"])[1:3],]
	for(j in 1:3){
		d = p[j,]
		png(paste0("CV.",ii,".low.log2MAD.",j,".gene.tpm.png"),width=600,height=500,units="px")
		hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="gene tpm",main=paste0("CV=",round(d[1,"CV"],4)," lgMAD=",round(d[1,"log2MAD"],4)," skewness=",round(d[1,"skewness"],4)))
		dev.off()
	}
	p = genetpm_p[order(genetpm_p[,"skewness"],decreasing=TRUE)[1:3],]
	for(j in 1:3){
		d = p[j,]
		png(paste0("CV.",ii,".high.skewness.",j,".gene.tpm.png"),width=600,height=500,units="px")
		hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="gene tpm",main=paste0("CV=",round(d[1,"CV"],4)," lgMAD=",round(d[1,"log2MAD"],4)," skewness=",round(d[1,"skewness"],4)))
		dev.off()
	}
}

#filter
genetpm_out = filter(genetpm, skewness<=2.2 & CV>0.4 & span>3)
print(nrow(genetpm_out))
#genetpm_out = filter(genetpm, skewness>2 & skewness<2.5 & log2Var>4 & log2MAD>0)
#print(nrow(genetpm_out))
#genetpm_out = filter(genetpm, (skewness<=2 & log2Var>-0.5 & log2MAD>-0.5) | (skewness>2 & skewness<2.5 & log2Var>4 & log2MAD>0))
#(sexRatio>0.2 & sexRatio<0.8 & skewness<=0.9 & log2Var>2 & log2MAD>0))
write.table(genetpm_out,file=paste0("gene.tpm.distri.filter.for.eQTL.txt"),quote=FALSE,sep="\t")

