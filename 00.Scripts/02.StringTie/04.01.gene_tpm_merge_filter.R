#combine all samples' genes TPM from "sample.gene_abund.txt" files
args = commandArgs(T) 
WKPATH = args[1]
OUTPATH = args[2]
setwd(WKPATH)
allfiles = list.files(path=".",pattern="*gene_abund.txt")
tmp = read.table(allfiles[1],row.names=1,header=T,sep="\t")
Data = matrix(data=NA,nrow=dim(tmp)[1],ncol=length(allfiles))
col_names = rep(NA,length(allfiles))
for(i in 1:length(allfiles)){
#  print(allfiles[i])
  tmp = read.table(allfiles[i],row.names=1,header=T,sep="\t")
  tmp = tmp[order(row.names(tmp)),]
  Data[,i] = tmp$TPM
#  print(unlist(strsplit(allfiles[i],"[.]")))
  col_names[i] = paste0("X",strsplit(allfiles[i],"[.]")[[1]])
#  print(col_names[i])
}
rownames(Data) = row.names(tmp)
colnames(Data) = col_names
write.table(Data,file=paste0(OUTPATH,"/all_gene_tpm.txt"),quote=F,sep="\t")


#Plot gene TPM
setwd(OUTPATH)
library(ggplot2)
rl = dim(Data)
p = ggplot()
for(i in 1:rl[2]){
	tmp = Data[,i]
	tmp = tmp[tmp>0.01]
	tmp = log2(tmp)
	p = p + geom_density(data=as.data.frame(tmp),aes(tmp),colour=alpha("black",0.1))
}
log2_pool_tpm = log2(Data[Data>0.01])
png("pool_tpm.hist.png")
hist(log2_pool_tpm,breaks=seq(-10,19,0.5),main="log2 transformed pooled TPM",xlab="log2TPM")
dev.off()
p = p + geom_density(data=as.data.frame(log2_pool_tpm),aes(log2_pool_tpm),colour="red")
p = p + labs(x="log2TPM")
ggsave("pool_tpm.density.png",plot=p,width=12,height=8,units="cm")



#filter gene by TPM>1 in at least 50% samples
data = Data
rl = dim(data)

each_sample_tpm_filter_percent = matrix(nrow=3,ncol=rl[2],data=NA)  #row1: percentage of TPM>1 in this sample; row2: percentage of TPM>1 in at least half samples; row3: log2TPM mean of each sample 
colnames(each_sample_tpm_filter_percent) = col_names
rownames(each_sample_tpm_filter_percent) = c("TPM>1","TPM>1inhalfsp","log2TPM_mean")
for(i in 1:rl[2]){
    each_sample_tpm_filter_percent[1,][i] = sum(data[,i]>1)
	tmp = data[,i]
	each_sample_tpm_filter_percent[3,][i] = mean(log2(tmp[tmp>0.01]))
}
remain_gene_list = rep(0,rl[1])
for(i in 1:rl[1]){
    remain_gene_list[i] = ((sum(data[i,]>1)) > (rl[2]/2))
}

each_sample_tpm_filter_percent[2,] = sum(remain_gene_list)
each_sample_tpm_filter_percent = each_sample_tpm_filter_percent*100/rl[1]
print(sum(remain_gene_list))
each_sample_tpm_filter_percent = rbind(names(data),each_sample_tpm_filter_percent)
write.table(t(each_sample_tpm_filter_percent),file="tpm_filter_stat.txt",quote=F,sep="\t")
write.table(rownames(data)[remain_gene_list==TRUE],file="remain_gene.list",quote=F,row.names=F,col.names=F)
