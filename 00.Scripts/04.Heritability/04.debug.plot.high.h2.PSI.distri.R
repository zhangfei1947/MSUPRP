args <- commandArgs(trailingOnly=TRUE)

args_psi = c("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/SE/filter/SE.PSI.filter.txt","/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/RI/filter/RI.PSI.filter.txt","/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/MXE/filter/MXE.PSI.filter.txt","/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A5SS/filter/A5SS.PSI.filter.txt","/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A3SS/filter/A3SS.PSI.filter.txt")

P1 <- read.table(args_psi[1],head=T,row.names=1)
P2 <- read.table(args_psi[2],head=T,row.names=1)
P3 <- read.table(args_psi[3],head=T,row.names=1)
P4 <- read.table(args_psi[4],head=T,row.names=1)
P5 <- read.table(args_psi[5],head=T,row.names=1)
P <- rbind(P1,P2)
P <- rbind(P,P3)
P <- rbind(P,P4)
P <- rbind(P,P5)

as = unlist(strsplit(args[1], ","))
d = P[as,]

setwd("high_h2_explore")
for(i in 1:length(as)){
	png(paste0(as[i],".PSI.png"),width=600,height=500,units="px")
	hist(as.numeric(d[i,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[i,"log2Var"],3)," lgMAD=",round(d[i,"log2MAD"],3)," lgMeanAD=",round(d[i,"log2MeanAD"],3)," skewness=",round(d[i,"skewness"],3)," sex=",round(d[i,"sexRatio"],2), " NAs=",d[i,"num_nan"]))
	dev.off()
}
