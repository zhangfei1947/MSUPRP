library(rrBLUP)

args <- commandArgs(trailingOnly=TRUE)

#PSI_file <- args[1]
#PSI_file <- args[2]
#PSI_file <- args[3]
#PSI_file <- args[4]
#PSI_file <- args[5]
geno_file <- args[6]
fix_file <- args[7]
wkpath <- args[8]

setwd(wkpath)
G <- read.table(geno_file,head=T,row.names=1)
G <- t(G)
K = A.mat(G)
X <- read.table(fix_file,head=T,row.names=1)
X <- as.matrix(X)

P1 <- read.table(args[1],head=T,row.names=1)
P2 <- read.table(args[2],head=T,row.names=1)
P3 <- read.table(args[3],head=T,row.names=1)
P4 <- read.table(args[4],head=T,row.names=1)
P5 <- read.table(args[5],head=T,row.names=1)
P <- cbind(P1,P2)
P <- cbind(P,P3)
P <- cbind(P,P4)
P <- cbind(P,P5)
P <- t(P)
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
write.table(out_put, file=paste0("rrBLUP.AS.txt"), quote=F, sep="\t")

