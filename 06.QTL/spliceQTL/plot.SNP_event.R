library(ggplot2)
args <- commandArgs(trailingOnly=TRUE)
type <- args[1]

PSI <- read.table(paste0("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.PSI/filterPSI/",type,"_PSI.filter.txt"),head=T,row.names=1)
SNP <- read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL/SNP.txt",head=T,row.names=1)
trans <- read.table(paste0("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL/",type,".trans.eqtl.xls.FDR_1e-4"),head=T,row.names=1)
cis <- read.table(paste0("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL/",type,".cis.eqtl.xls.FDR_1e-4"),head=T,row.names=1)

PSIplot <- function(x){
    ss <- x[1]
    ee <- x[2]
    genotype <- SNP[ss,]
    psi <- PSI[ee,]
    g0 <- as.data.frame(psi[genotype==0])
    g0$genotype <- rep("g0", length(g0[,1]))
    g1 <- as.data.frame(psi[genotype==1])
    g1$genotype <- rep("g1", length(g1[,1]))
    g2 <- as.data.frame(psi[genotype==2])
    g2$genotype <- rep("g2", length(g2[,1]))
    colnames(g0) <- c("PSI","genotype")
    colnames(g1) <- c("PSI","genotype")
    colnames(g2) <- c("PSI","genotype")
    plotdata <- rbind(g0,g1,g2)
    p <- ggplot(plotdata,aes(x=genotype,y=PSI)) + geom_boxplot(outlier.shape=NA,aes(colour=genotype)) + geom_jitter(height=2,aes(colour=genotype)) + ylim(0,110)
    ggsave(file=paste0(type,"/",ss,"_",ee,"_SNP_event.png"),plot=p)
    }

apply(trans, 1, PSIplot)
apply(cis, 1, PSIplot)
