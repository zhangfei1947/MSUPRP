##parameters:  shuffle or not (1,0); split num (int)
args <- commandArgs(trailingOnly = TRUE)
shuffle = as.numeric(args[1])
splitnum = as.numeric(args[2])

d = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/aspsi.nqt.gcta.pheno.txt.withheader",header=TRUE,row.names=NULL)
rs = dim(d)[1]
cs = dim(d)[2]

if (shuffle) {
	num_sample = rs
	rds = sample(1:num_sample,num_sample)
	d12 = d[,c(1,2)]
	d3 = d[,-c(1,2)]
	d12 = d12[rds,]
	d = cbind(d12,d3)
}

num_pheno = cs-2
split_length = round(num_pheno/splitnum)+2
starts = 3
ends = starts + split_length
i = 0
while (starts<=cs) {
	i = i+1
	sub_d = d[,c(1,2,seq(starts,ends))]
	write.table(sub_d,file=sprintf("genetpm.nqt.gcta.pheno.txt.%02d",i),quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
	write.table(colnames(sub_d)[-c(1,2)],file=sprintf("genetpm.nqt.gcta.pheno.txt.%02d.names",i),quote=FALSE,sep="\t",row.names=FALSE,col.names=FALSE)
	starts = ends + 1
	ends = min(starts + split_length, cs)
}
