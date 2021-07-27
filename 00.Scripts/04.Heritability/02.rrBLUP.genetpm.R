library(rrBLUP)
library(bestNormalize)

args <- commandArgs(trailingOnly=TRUE)
genetpm_file <- args[1]
geno_file <- args[2]
fix_file <- args[3]
wkpath <- args[4]

setwd(wkpath)
G <- read.table(geno_file,head=T,row.names=1)
G <- t(G)
K = A.mat(G)
X <- read.table(fix_file,head=T,row.names=1)
X <- as.matrix(X)
P_raw <- read.table(genetpm_file,head=T,row.names=1)
P_raw = P_raw[,1:144]
P_raw = P_raw[,-which(names(P_raw) == "X1833")]

# Normal quantile transformation
nqt_row <- function(row){
    obj = orderNorm(row)
    predict(obj)
}
P = apply(P_raw, 1, nqt_row)
P = t(P)
#


r <- row.names(P)
P <- apply(P,2,as.numeric)

run_mixedsolve <- function(P1){
    fit1 <- mixed.solve(P1,K=K,X=X)
    fit2 <- mixed.solve(P1,K=NULL,X=X)
    cq <- 2*(fit1$LL-fit2$LL)
    h2 <- fit1$Vu/(fit1$Vu+fit1$Ve)
    M <- mad(P1,na.rm=TRUE)
    pv <- pchisq(cq, df=1, lower.tail=F)
    c(h2, M, pv)
}

out_put <- apply(P, 1, run_mixedsolve)
out_put <- t(out_put)
out_put <- as.data.frame(out_put)
colnames(out_put) <- c("h2","MAD","pValue")
rownames(out_put) <- r
out_put$qValue <- p.adjust(out_put$pValue, method='fdr')
write.table(out_put, file=paste0("rrBLUP.genetpm.txt"), quote=F, sep="\t")

