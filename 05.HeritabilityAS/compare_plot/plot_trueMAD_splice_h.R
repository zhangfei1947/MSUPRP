library(ggplot2)
library(DescTools)

sps <- c("SE","MXE","RI","A5SS","A3SS")
for (sp in sps) {
    datah <- read.table(paste0("rrBLUP.",sp,"_PSI.xls"), header=T, row.names=1)
    datapsi <- read.table(paste0(sp,"_PSI.filter.txt"), header=T, row.names=1)
    datah$nqtMAD <- datah$MAD
    datah$MAD <- apply(datapsi,1,mad,na.rm=T)
    datah$MeanAD <- apply(datapsi,1,MeanAD,na.rm=T)
    datah$h <- sqrt(datah$h2)
    print(min(datah$MeanAD))
    print(head(datah))
    p <-  ggplot(datah, aes(h, MAD)) + geom_point()
    ggsave(paste0(sp,".h_MAD.png"),plot=p)
    p <-  ggplot(datah, aes(h, MeanAD)) + geom_point() + scale_y_continuous(limits = c(0, 50))
    ggsave(paste0(sp,".h_MeanAD.png"),plot=p)
    p <-  ggplot(datah, aes(h, nqtMAD)) + geom_point()
    ggsave(paste0(sp,".h_nqtMAD.png"),plot=p)
}
