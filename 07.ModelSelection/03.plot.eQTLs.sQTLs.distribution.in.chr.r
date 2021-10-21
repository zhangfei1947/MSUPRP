library(ggplot2)
library(tidyr)
library(dplyr)

eQTL_count_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/01.eQTL/plot.qtls.distri.tmp.txt"
sQTL_count_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL/plot.qtls.distri.tmp.txt"

outdir = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection"
setwd(outdir)

eqtl = read.table(eQTL_count_file) #1diff_chr, 2samechr_far, 3samechr_near, 4exon, 5intron, 6TSS_distance, 7TES_distance, 8gene/AS, 9SNP, 10intron_distance
sqtl = read.table(sQTL_count_file) 


#TSS TES distance plot 

distance_data = as.data.frame(rbind(eqtl[,6:7], sqtl[,6:7]))
colnames(distance_data) = c("TSS","TES")
distance_data$type = c(rep("eQTL",nrow(eqtl)),rep("sQTL",nrow(sqtl)))
distance_data = gather(distance_data, key="TSSTES", value="distance", -type)
distance_data = na.omit(distance_data) 

distance_data = filter(distance_data, (TSSTES=="TSS" & distance>-40000 & distance<4000) | (TSSTES=="TES" & distance>-4000 & distance<40000))


png("test1.png")
hist(distance_data[which(distance_data$TSSTES=="TSS"),"distance"],breaks=seq(-40000,4000,2000))
dev.off()
png("test2.png")
hist(distance_data[which(distance_data$TSSTES=="TES"),"distance"],breaks=seq(-4000,40000,2000))
dev.off()


distance_data[which(distance_data$TSSTES=="TES"),"distance"] = distance_data[which(distance_data$TSSTES=="TES"),"distance"] + 10000


png("test3.png")
hist(distance_data$distance,breaks=seq(-40000,50000,2000))
dev.off()

p = ggplot(distance_data,aes(distance)) + geom_freqpoly(breaks=seq(-40000,50000,2000),aes(color=type, linetype=type)) +  geom_point(stat="bin", aes(y=..count..,color=type), breaks=seq(-40000,50000,2000)) + xlim(-40000,50000) + 
	scale_x_continuous(breaks=c(-40000,-20000,0,10000,30000,50000),labels=c("-40","-20","TSS","TES","20","40")) 
ggsave("QTL.distance.png",plot=p, width=20, height=10, units = "cm")


#intron distance plot



q()


#bar plot

bar_data = as.data.frame(rbind(colSums(eqtl[,1:5]), colSums(sqtl[,1:5])))
colnames(bar_data) = c("diff_chr","remote","adjacent","exon","intron")
bar_data$type = c("eQTL","sQTL")

bar_data = gather(bar_data, key="stat", value="count", -type)
bar_data$type = factor(bar_data$type, levels=c("sQTL","eQTL"))
#bar_data$stat = factor(bar_data$stat, levels=c("diff_chr","remote","adjacent","exon","intron"))

print(bar_data)


mycols = c("#0073C2FF", "#CD534CFF")
plot_data = bar_data
plot_data$stat[which(plot_data$stat %in% c("remote","adjacent","exon","intron"))] = "same_chr"
plot_data$stat = factor(plot_data$stat, levels=c("diff_chr","same_chr"))
p = ggplot(plot_data) + 
	geom_col(aes(x=count,y=type,fill=stat),width=0.9,position=position_fill()) +  scale_fill_manual(values = mycols) +
	coord_polar("x", start=0) + labs(x="",y="") + theme_void() + 
	theme(legend.position="bottom", legend.title=element_blank(), legend.key.size = unit(0.5,'cm')) + 
	geom_text(aes(y=type,x=0,label=type), color="white", size=5)
ggsave("qtl_count.1.png",plot=p, width=10, height=10, units = "cm")


mycols = c("#CD534CFF", "#006400", "#008B8B")
plot_data = bar_data
plot_data = plot_data[which(plot_data$stat %in% c("adjacent","exon","intron")),]
plot_data$stat = factor(plot_data$stat, levels=c("adjacent","exon","intron"))
p = ggplot(plot_data) + 
	geom_col(aes(x=count,y=type,fill=stat),width=0.9,position=position_fill()) +  scale_fill_manual(values = mycols) +
	coord_polar("x", start=0) + labs(x="",y="") + theme_void() + 
	theme(legend.position="bottom", legend.title=element_blank(), legend.key.size = unit(0.5,'cm')) + 
	geom_text(aes(y=type,x=0,label=type), color="white", size=5)
ggsave("qtl_count.2.png",plot=p, width=10, height=10, units = "cm")

mycols = c( "#006400", "#008B8B")
plot_data = bar_data
plot_data = plot_data[which(plot_data$stat %in% c("exon","intron")),]
plot_data$stat = factor(plot_data$stat, levels=c("exon","intron"))
p = ggplot(plot_data) + 
	geom_col(aes(x=count,y=type,fill=stat),width=0.9,position=position_fill()) + scale_fill_manual(values = mycols) +
	coord_polar("x", start=0) + labs(x="",y="") + theme_void() + 
	theme(legend.position="bottom", legend.title=element_blank(), legend.key.size = unit(0.5,'cm')) + 
	geom_text(aes(y=type,x=0,label=type), color="white", size=5)
ggsave("qtl_count.3.png",plot=p, width=10, height=10, units = "cm")



