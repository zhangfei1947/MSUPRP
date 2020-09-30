library(DescTools)
library(ggplot2)
args <- commandArgs(trailingOnly=TRUE)
PSI_file <- args[1]
type <- unlist(strsplit(PSI_file, "[.]"))[[1]]
PSI_file
type


sex_dat <- read.table("fixed.effects.xls.144",head=T,row.names=1)
sex_dat <- t(sex_dat)

data <- read.table(PSI_file,head=T,row.names=1)
## count NA number of each line
any_nan <- function(x){sum(is.nan(as.numeric(x)))}
data2 <- apply(data, 1, any_nan)
data2 <- as.data.frame(data2)
colnames(data2) <- c("nan_num")
## calculate Var and logVar
data3 <- apply(data,1,var,na.rm=TRUE)
data4 <- log(data3)
data3 <- as.data.frame(data3)
colnames(data3) <- c("Var")
data4 <- as.data.frame(data4)
colnames(data4) <- c("logVar")
## count number of PSIs in (0,2)
any_1 <- function(x){sum(as.numeric(x)<=2, na.rm=TRUE)}
data5 <- apply(data, 1, any_1)
data5 <- as.data.frame(data5)
colnames(data5) <- c("num_2")
## count number of PSIs in (98,100)
any_99 <- function(x){sum(as.numeric(x)>=98, na.rm=TRUE)}
data6 <- apply(data, 1, any_99)
data6 <- as.data.frame(data6)
colnames(data6) <- c("num_98")
## calculate MAD of each line
mad2 <- function(line){mad(as.numeric(line),na.rm=TRUE)}
data7 <- apply(data, 1, mad2)
data7 <- as.data.frame(data7)
colnames(data7) <- c("MAD")
## calculate MeanAD of each line
MeanAD2 <- function(line){MeanAD(as.numeric(line),na.rm=TRUE)}
data8 <- apply(data, 1, MeanAD2)
data8 <- as.data.frame(data8)
colnames(data8) <- c("MeanAD")
## count sex number of each line
countsex <- function(line){
    n = length(which(!is.na(line)=="True"))
    s = sum(as.vector(sex_dat[!is.na(line)]))
    s/n
}
data9 <- apply(data, 1, countsex)
data9 <- as.data.frame(data9)
colnames(data9) <- c("sex")



## combine all statistic
data <- cbind(data,data2,data3,data4,data5,data6,data7,data8,data9)
## first filter data by nan_num
data_filter <- subset(data, nan_num<72 & MeanAD>5 & sex>0.2 & sex<0.8)
length(data_filter[,1])/length(data[,1])



## plot nan distri
p <- ggplot(data,aes(nan_num)) + geom_histogram(binwidth=5)
ggsave(file=paste0(type,"_PSI_nan_distri.png"), plot=p)
## plot Var distri
p <- ggplot(data,aes(Var)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_var_distri.png"), plot=p)
## plot LogVar distri
p <- ggplot(data,aes(logVar)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_logvar_distri.png"), plot=p)
## plot all PSI distri and all atanPSI distri
PSIs <- as.numeric(na.omit(unlist(data[,1:144])))
PSIs <- as.data.frame(PSIs)
colnames(PSIs) <- c("PSI")
p <- ggplot(PSIs,aes(x=PSI)) + geom_histogram(binwidth=5)
ggsave(file=paste0(type,"_PSI_distri.png"), plot=p)
atanPSIs <- atan(PSIs)
colnames(atanPSIs) <- c("atanPSI")
p <- ggplot(atanPSIs,aes(x=atanPSI)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_atanPSI_distri.png"), plot=p)
##plot MAD distri
p <- ggplot(data,aes(MAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_MAD_distri.png"), plot=p)
## save tables
write.table(data,file=paste0(type,"_PSI.statistic.txt"),quote=F,sep="\t")
write.table(data_filter,file=paste0(type,"_PSI.filter.nan.var.MAD.txt"),quote=F,sep="\t")
write.table(data_filter[,1:144],file=paste0(type,"_PSI.filter.txt"),quote=F,sep="\t")

## After filter distri stat
data <- data_filter[,1:144]
## count NA number of each line 
any_nan <- function(x){sum(is.nan(as.numeric(x)))}
data2 <- apply(data, 1, any_nan)
data2 <- as.data.frame(data2)
colnames(data2) <- c("nan_num")
## calculate Var and logVar
data3 <- apply(data,1,var,na.rm=TRUE)
data4 <- log(data3)
data3 <- as.data.frame(data3)
colnames(data3) <- c("Var")
data4 <- as.data.frame(data4)
colnames(data4) <- c("logVar")
## count number of PSIs in (0,2)
any_1 <- function(x){sum(as.numeric(x)<=2, na.rm=TRUE)}
data5 <- apply(data, 1, any_1)
data5 <- as.data.frame(data5)
colnames(data5) <- c("num_2")
## count number of PSIs in (98,100)
any_99 <- function(x){sum(as.numeric(x)>=98, na.rm=TRUE)}
data6 <- apply(data, 1, any_99)
data6 <- as.data.frame(data6)
colnames(data6) <- c("num_98")
## calculate MAD of each line
mad2 <- function(line){mad(as.numeric(line),na.rm=TRUE)}
data7 <- apply(data, 1, mad2)
data7 <- as.data.frame(data7)
colnames(data7) <- c("MAD")
## calculate MeanAD of each line
MeanAD2 <- function(line){MeanAD(as.numeric(line),na.rm=TRUE)}
data8 <- apply(data, 1, MeanAD2)
data8 <- as.data.frame(data8)
colnames(data8) <- c("MeanAD")
## count sex number of each line
countsex <- function(line){
    n = length(which(!is.na(line)=="True"))
    s = sum(as.vector(sex_dat[!is.na(line)]))
    s/n
}
data9 <- apply(data, 1, countsex)
data9 <- as.data.frame(data9)
colnames(data9) <- c("sex")


data <- cbind(data,data2,data3,data4,data5,data6,data7,data8,data9)

## plot nan distri
p <- ggplot(data,aes(nan_num)) + geom_histogram(binwidth=5) + xlim(0,150)
ggsave(file=paste0(type,"_filtered_PSI_nan_distri.png"), plot=p)
## plot Var distri
p <- ggplot(data,aes(Var)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_filtered_PSI_var_distri.png"), plot=p)
## plot LogVar distri
p <- ggplot(data,aes(logVar)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_filtered_PSI_logvar_distri.png"), plot=p)
## plot all PSI distri and all atanPSI distri
PSIs <- as.numeric(unlist(data[,1:144]))
PSIs <- as.data.frame(PSIs)
colnames(PSIs) <- c("PSI")
p <- ggplot(PSIs,aes(x=PSI)) + geom_histogram(binwidth=5)
ggsave(file=paste0(type,"_filtered_PSI_distri.png"), plot=p)
atanPSIs <- atan(PSIs)
colnames(atanPSIs) <- c("atanPSI")
p <- ggplot(atanPSIs,aes(x=atanPSI)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_filtered_atanPSI_distri.png"), plot=p)
##plot MAD distri
p <- ggplot(data,aes(MAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_filtered_PSI_MAD_distri.png"), plot=p)

