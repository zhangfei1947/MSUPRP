library(ggplot2)

data <- read.table("SE.PSI.txt",head=T,row.names=1)
sum(is.nan(as.numeric(data[12, ])))
data2 <- as.matrix(data)
sum(which(is.nan(data2[8,])))


any_nan <- function(x){sum(is.nan(as.numeric(x)))}

data2 <- apply(data, 1, any_nan)

data3 <- as.data.frame(data2)

colnames(data3) <- c("nan_num")

data4 <- cbind(data, data3)

data5 <- apply(data,1,var)

data6 <- log(data5)

data5 <- as.data.frame(data5)

colnames(data5) <- c("Var")

data6 <- as.data.frame(data6)

colnames(data6) <- c("logVar")

data7 <- cbind(data4,data5,data6)

data8 <- subset(data7,nan_num<50 & logVar>-5)

length(data8[,1])/103969

p <- ggplot(data7,aes(nan_num)) + geom_histogram(binwidth=5)


data9 <- data8[,1:144]

data9 <- as.numeric(unlist(data9))

data9 <- as.data.frame(data9)

data9 <- na.omit(data9)
p <- ggplot(data9,aes("data9")) + geom_histogram(bins=50)
ggsave("PSI_distri.pdf", plot=p)


data10 <- as.data.frame(data9)
colnames(data10) <- c("PSI")
p <- ggplot(data10,aes(x=PSI)) + geom_histogram(bins=50)
ggsave("PSI_distri.pdf", plot=p)



data11 <- atan(data9)
data10 <-cs.data.frame(data11)
data10 <- as.data.frame(data11)
colnames(data10) <- c("atanPSI")
p <- ggplot(data10,aes(x=atanPSI)) + geom_histogram(bins=50)
ggsave("atanPSI_distri.pdf", plot=p)

write.table(data8,"PSI.R.filter.txt",quote=F)

write.table(data8[,1:144],"PSI.R.filter.clean.txt",quote=F)



