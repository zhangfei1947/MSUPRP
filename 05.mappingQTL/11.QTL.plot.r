
library(qqman)

#eQTL
eQTL_dir = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL"
setwd(eQTL_dir)
eQTL_file = "QTL.results.txt"
gwasResults = read.table(eQTL_file,header=TRUE,row.names=NULL)
png("eQTL.manhattan.pval.png", width=1000, height=600)
manhattan(gwasResults, chr="snpchr", bp="pos", snp="snp", p="pvalue")
dev.off()
png("eQTL.manhattan.fdr.png", width=1000, height=600)
manhattan(gwasResults, chr="snpchr", bp="pos", snp="snp", p="FDR")
dev.off()
png("eQTL.qqplot.pvalue.png", width=600, height=600)
qq(gwasResults$pvalue)
dev.off()
png("eQTL.qqplot.fdr.png", width=600, height=600)
qq(gwasResults$FDR)
dev.off()

#sQTL

eQTL_dir = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL"
setwd(eQTL_dir)
eQTL_file = "QTL.results.txt"
gwasResults = read.table(eQTL_file,header=TRUE,row.names=NULL)
png("sQTL.manhattan.pval.png", width=1000, height=600)
manhattan(gwasResults, chr="snpchr", bp="pos", snp="snp", p="pvalue")
dev.off()
png("sQTL.manhattan.fdr.png", width=1000, height=600)
manhattan(gwasResults, chr="snpchr", bp="pos", snp="snp", p="FDR")
dev.off()
png("sQTL.qqplot.pvalue.png", width=600, height=600)
qq(gwasResults$pvalue)
dev.off()
png("sQTL.qqplot.fdr.png", width=600, height=600)
qq(gwasResults$FDR)
dev.off()

