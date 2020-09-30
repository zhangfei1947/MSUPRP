library(ggplot2)
args <- commandArgs(trailingOnly=TRUE)
type <- args[1]

PSI <- read.table(paste0(type,"_PSI.nqt"),head=T,row.names=1)
SNP <- read.table("SNP.txt",head=T,row.names=1)
trans <- read.table(paste0(type,".trans.eqtl.xls.FDR_0.01"),head=T,row.names=1)
cis <- read.table(paste0(type,".cis.eqtl.xls.FDR_0.01"),head=T,row.names=1)

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
    colnames(g0) <- c("nqtPSI","genotype")
    colnames(g1) <- c("nqtPSI","genotype")
    colnames(g2) <- c("nqtPSI","genotype")
    plotdata <- rbind(g0,g1,g2)
    p <- ggplot(plotdata,aes(x=genotype,y=nqtPSI)) + geom_boxplot(outlier.shape=NA,aes(colour=genotype)) + geom_jitter(height=2,aes(colour=genotype)) + ylim(0,1.1)
    ggsave(file=paste0(type,"/",ss,"_",ee,"_SNP_event.png"),plot=p)
    }

apply(trans, 1, PSIplot)
apply(cis, 1, PSIplot)
