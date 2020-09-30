library(fdrtool)

dat <- read.table("rrBLUP.output.gene_expression.xls",head=T,row.names=1)
p <- as.vector(dat$pValue)
fdr <- fdrtool(p,statistic="pvalue")
dat$qValue <- fdr$qval
write.table(dat, file="rrBLUP.output.gene_expression.qValue.xls", quote=F, sep="\t")


dat <- read.table("rrBLUP.output.isoform_ratio.xls",head=T,row.names=1)
p <- as.vector(dat$pValue)
fdr <- fdrtool(p,statistic="pvalue")
dat$qValue <- fdr$qval
write.table(dat, file="rrBLUP.output.isoform_ratio.qValue.xls", quote=F, sep="\t")
