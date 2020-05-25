library(rrBLUP)
args <- commandArgs(trailingOnly=TRUE)
PSI_nqt_file <- args[1]
type <- unlist(strsplit(PSI_nqt_file, "[.]"))[[1]]

G <- read.table("rrBLUP.genotype.xls.144",head=T,row.names=1)
G <- t(G)
K = A.mat(G)
X <- read.table("fixed.effects.xls.144",head=T,row.names=1)
X <- as.matrix(X)
P <- read.table(PSI_nqt_file,head=T,row.names=1)
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
colnames(out_put) <- c("h2","MAD","pValue")
rownames(out_put) <- r
write.table(out_put, file=paste0("rrBLUP.",type,".xls"), quote=F, sep="\t")

