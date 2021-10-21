library(ggplot2)
library(matrixStats)
library(dplyr)
library(DescTools)
library(moments)
library(bestNormalize)

args = commandArgs(T)
type = args[1]
psi = args[2]
outpath = args[3]
sexfile = args[4]

setwd(outpath)
data = read.table(psi,header=T,row.names=1)
N = ncol(data)
data[sapply(data,is.infinite)] = NA

sex_dat = read.table(sexfile,head=T,row.names=1)
sex_dat = t(sex_dat)
sex_dat = sex_dat[,names(data)]

dataout = data
data = as.matrix(data)
dataout$num_nan = rowSums(is.na(data))
dataout$num_2 = rowSums(data<2)
dataout$num_2 = dataout$num_2[dataout$num_2==NA]=0
dataout$num_100 = rowSums(data>98)
dataout$num_100 = dataout$num_100[dataout$num_100==NA]=0
#dataout$num_extre = rowMaxs(cbind(dataout$num_nan+dataout$num_2, dataout$num_nan+dataout$num_100))
dataout$Var = rowVars(data,na.rm=TRUE)
dataout$MAD = rowMads(data,na.rm=TRUE)
MeanAD2 <- function(line){MeanAD(as.numeric(line),na.rm=TRUE)}
dataout$MeanAD <- apply(data, 1, MeanAD2)
sexR <- function(line){
	idx = which(line>0)
	l = length(idx)
	sum(sex_dat[idx])/l
}
dataout$sexRatio <- apply(data, 1, sexR)


# 1st step filter: NAs< 2/3 sample
dataout = dataout[which(dataout$num_nan<(N*0.666)),]  # no more than 2/3 samples is NA
# 2nd step filter: Var > 0.01
dataout = dataout[which(dataout$Var>0.01),]
dataout$log2Var = log2(dataout$Var+0.0001)
dataout$log2MAD = log2(dataout$MAD+0.0001)
dataout$log2MeanAD = log2(dataout$MeanAD+0.0001)
sk <- function(line){abs(skewness(line[1:143],na.rm=TRUE))}
dataout$skewness = apply(dataout, 1, sk)
ku <- function(line){kurtosis(line[1:143],na.rm=TRUE)}
dataout$kurtosis = apply(dataout, 1, ku)
#print(dataout[1:10,144:152])
#print(dataout[which(dataout$Var>1000),144:149])

png(paste0(type,"_poolPSI_distri.png"))
hist(as.numeric(unlist(dataout[,1:143])),main="pool PSI",xlab="PSI",breaks=100)
dev.off()

p <- ggplot(dataout,aes(num_nan)) + geom_histogram(binwidth=1)
ggsave(file=paste0(type,"_PSI_nan_distri.png"), plot=p)

p <- ggplot(dataout,aes(Var)) + geom_histogram(bins=100)
ggsave(file=paste0(type,"_PSI_Var_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2Var)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2Var_distri.png"), plot=p)

p <- ggplot(dataout,aes(MAD)) + geom_histogram(bins=100)
ggsave(file=paste0(type,"_PSI_MAD_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2MAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2MAD_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2MeanAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2MeanAD_distri.png"), plot=p)

p <- ggplot(dataout,aes(sexRatio)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_sexRatio_distri.png"), plot=p)

p <- ggplot(dataout,aes(skewness)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_skewness_distri.png"), plot=p)

png("log2Var_log2MAD.png")
plot(log2MAD~log2Var,data=dataout)
dev.off()

png("log2Var_log2MeanAD.png")
plot(log2MeanAD~log2Var,data=dataout)
dev.off()

png("log2Var_skewness.png")
plot(skewness~log2Var,data=dataout)
dev.off()

## log2Var - PSI distri
if(FALSE){

val = c(-1,0,2,3,4,5,6,7,8,9,10,11)
for(each in val){
	d = filter(dataout,log2Var>each & log2Var<(each+0.01))
	if(nrow(d)>2){
		png(paste0("log2Var.",each,".1.PSI.png"),width=600,height=500,units="px")
		hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
		dev.off()
		png(paste0("log2Var.",each,".2.PSI.png"),width=600,height=500,units="px")
		hist(as.numeric(d[2,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[2,"log2Var"],4)," lgMAD=",round(d[2,"log2MAD"],4)," lgMeanAD=",round(d[2,"log2MeanAD"],4)," skewness=",round(d[2,"skewness"],4)," kurtosis=",round(d[2,"kurtosis"],4)))
		dev.off()
		png(paste0("log2Var.",each,".3.PSI.png"),width=600,height=500,units="px")
		hist(as.numeric(d[3,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[3,"log2Var"],4)," lgMAD=",round(d[3,"log2MAD"],4)," lgMeanAD=",round(d[3,"log2MeanAD"],4)," skewness=",round(d[3,"skewness"],4)," kurtosis=",round(d[3,"kurtosis"],4)))
		dev.off()
	}
}

}


## find some sample for regression keep or not
if(FALSE){

datareg = filter(dataout,skewness>-2 & skewness<0 & kurtosis<4 & kurtosis>0 & sexRatio>0.2 & sexRatio<0.8)
datareg =  datareg[sample(nrow(datareg),200),]
for(i in 1:200){
	d = datareg[i,]
	rn = rownames(d)
	ii = sprintf("%03d", i)
	png(paste0(ii,".",rn,".PSI.regression.png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
write.table(datareg,file=paste0(type,".PSI.regression.txt"),quote=FALSE,sep="\t")

}

if(FALSE){

## TEST: find if there are log2Var<3 but log2MAD>0 and skewness in (-1,1)
#dataout_test = filter(dataout, sexRatio>0.2 & sexRatio<0.8 & skewness<=0.9 & log2Var>2 & log2MAD>0)
dataout_test = filter(dataout, (sexRatio>0.2 & sexRatio<0.8 & skewness>0.9 & skewness<1.1 & log2Var>3 & log2MAD>0) | (sexRatio>0.2 & sexRatio<0.8 & skewness<=0.9 & log2Var>2 & log2MAD>0))

print(nrow(dataout_test))
datareg = dataout_test[order(dataout_test[,"log2Var"])[1:5],]
for(i in 1:5){
	d = datareg[i,]
	rn = rownames(d)
	png(paste0(rn,".PSI.distri.test.png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout_test[order(dataout_test[,"log2MAD"])[1:5],]
for(i in 1:5){
	d = datareg[i,]
	rn = rownames(d)
	png(paste0(rn,".PSI.distri.test.png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout_test[order(dataout_test[,"skewness"],decreasing=TRUE)[1:5],]
for(i in 1:5){
	d = datareg[i,]
	rn = rownames(d)
	png(paste0(rn,".PSI.distri.test.png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}

}

## final filter: log2MAD > 0 & log2Var > 2 & sexratio: 0.2~0.8 & skewness<1.1
setwd("filter")
dataout = filter(dataout, (sexRatio>0.2 & sexRatio<0.8 & skewness<1.1 & log2Var>2 & log2MAD>0))
write.table(dataout,file=paste0(type,".PSI.filter.txt"),quote=FALSE,sep="\t")
# Normal quantile transformation
nqt_row <- function(row){
	row = row[1:143]
    obj = orderNorm(row)
    predict(obj)
}
dataout_nqt = apply(dataout, 1, nqt_row)
write.table(dataout_nqt,file=paste0(type,".PSI.filter.nqt.txt"),quote=FALSE,sep="\t")
# plot filtered
datareg =  dataout[sample(nrow(dataout),20),]
for(i in 1:20){
	d = datareg[i,]
	rn = rownames(d)
	ii = sprintf("%02d", i)
	png(paste0(ii,".",rn,".PSI.distri.png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout[order(dataout[,"log2MAD"])[1:5],]
for(i in 1:5){
	d = datareg[i,]
	ii = sprintf("%02d", i)
	png(paste0("PSI.low.log2MAD.",ii,".png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout[order(dataout[,"log2Var"])[1:5],]
for(i in 1:5){
	d = datareg[i,]
	ii = sprintf("%02d", i)
	png(paste0("PSI.low.log2Var.",ii,".png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout[order(dataout[,"skewness"])[1:5],]
for(i in 1:5){
	d = datareg[i,]
	ii = sprintf("%02d", i)
	png(paste0("PSI.low.skewness.",ii,".png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}
datareg = dataout[order(dataout[,"skewness"],decreasing=TRUE)[1:5],]
for(i in 1:5){
	d = datareg[i,]
	ii = sprintf("%02d", i)
	png(paste0("PSI.high.skewness.",ii,".png"),width=600,height=500,units="px")
	hist(as.numeric(d[1,1:143]),na.rm=TRUE,,xlab="PSI",main=paste0("lgVar=",round(d[1,"log2Var"],4)," lgMAD=",round(d[1,"log2MAD"],4)," lgMeanAD=",round(d[1,"log2MeanAD"],4)," skewness=",round(d[1,"skewness"],4)," kurtosis=",round(d[1,"kurtosis"],4)))
	dev.off()
}


png(paste0(type,"_poolPSI_distri.png"))
hist(as.numeric(unlist(dataout[,1:143])),main="pool PSI",xlab="PSI",breaks=100)
dev.off()

p <- ggplot(dataout,aes(num_nan)) + geom_histogram(binwidth=1)
ggsave(file=paste0(type,"_PSI_nan_distri.png"), plot=p)

p <- ggplot(dataout,aes(Var)) + geom_histogram(bins=100)
ggsave(file=paste0(type,"_PSI_Var_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2Var)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2Var_distri.png"), plot=p)

p <- ggplot(dataout,aes(MAD)) + geom_histogram(bins=100)
ggsave(file=paste0(type,"_PSI_MAD_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2MAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2MAD_distri.png"), plot=p)

p <- ggplot(dataout,aes(log2MeanAD)) + geom_histogram(bins=50)
ggsave(file=paste0(type,"_PSI_log2MeanAD_distri.png"), plot=p)

