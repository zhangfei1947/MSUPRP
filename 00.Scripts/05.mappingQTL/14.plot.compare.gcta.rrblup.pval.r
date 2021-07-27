
args <- commandArgs(trailingOnly=TRUE)
gcta_out_path = args[1]
rrblup_out_file = args[2]
outpath = args[3]
setwd(outpath)

rrblup_out = read.table(rrblup_out_file,header=TRUE,row.names=1,as.is=TRUE)  #snp     chr     pos     MSTRG.10067     MSTRG.10171
for (i in 4:24) {
	rrblup_pval = rrblup_out[,c(1,i)]
	rownames(rrblup_pval) = rrblup_pval[,1]
	gene = colnames(rrblup_out)[i]
	fastGWA_file = paste0(gcta_out_path,"/",gene,".fastGWA")
	gcta_out = read.table(fastGWA_file,header=TRUE,row.names=NULL,as.is=TRUE) #CHR     SNP     POS     A1      A2      N       AF1     BETA    SE      P
	gcta_pval = gcta_out[,c("SNP","P")]
	rownames(gcta_pval) = gcta_pval[,1]
	SNPs = intersect(rrblup_pval[,1],gcta_pval[,1])
	rrblup_pval = rrblup_pval[SNPs,]
	gcta_pval = gcta_pval[SNPs,]
	png(paste0(gene,".gcta.rrblup.pvalues.png"),width=600,height=600)
	plot(x=rrblup_pval[,2], y=-log10(gcta_pval[,2]), main=gene, xlab="rrBLUP pvalues", ylab="gcta pvalues")
	dev.off()
}
