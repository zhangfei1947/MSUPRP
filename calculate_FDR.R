library(fdrtool)
args <- commandArgs(trailingOnly=TRUE)
rrblup_file <- args[1] # rrBLUP.A5SS_PSI.xls
type <- unlist(strsplit(rrblup_file, "[.]"))[[2]]

dat <- read.table(rrblup_file,head=T,row.names=1)
p <- as.vector(dat$pValue)
fdr <- fdrtool(p,statistic="pvalue")
dat$qValue <- fdr$qval
write.table(dat, file=paste0("rrBLUP.",type,".qValue.xls"), quote=F, sep="\t")

