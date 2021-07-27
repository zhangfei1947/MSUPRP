#bar plot for total reads and unique concordantly mapped reads

WKDIR = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/02.mapping_stat"
map_stat_file = "mapping_stat.txt"


setwd(WKDIR)
data = read.table(map_stat_file,header=T,row.names=1)
data$uniq_concordant_reads = as.numeric(gsub("\\(.*\\)","",data$uniq_concordant_mapped))
data$totalNotUniqconcord = data$total_reads - data$uniq_concordant_reads

#uniq concordant mapped reads doge
dataplot = data[,c("uniq_concordant_reads","totalNotUniqconcord")]
dataplot = t(dataplot/1000000)
png("mapped.stat.png",width=2000,height=600,units="px")
barplot(height=dataplot,ylab="uniquely concordant mapped/total reads(M)",las=2)
abline(h=10,lty=2,col=rgb(0.8,0.8,0.8))
dev.off()

#uniq concordant mapped reads percentage
data$uniq_concordant_reads = data$uniq_concordant_reads/data$total_reads*100
data$totalNotUniqconcord = data$totalNotUniqconcord/data$total_reads*100
dataplot = data[,c("uniq_concordant_reads","totalNotUniqconcord")]
dataplot = t(dataplot)
png("mapped.stat.percent.png",width=2000,height=600,units="px")
barplot(height=dataplot,ylab="uniquely concordant mapped/total reads(percentage)",las=2)
abline(h=50,lty=2,col=rgb(0.8,0.8,0.8))
dev.off()