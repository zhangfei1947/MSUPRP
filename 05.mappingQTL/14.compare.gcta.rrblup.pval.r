## parameters:		pheno.rrblup.txt		geno.rrblup.txt		QTL.results.pval.1e-20.txt		outpath

library(rrBLUP)
args = commandArgs(trailingOnly=TRUE)
pheno_file = args[1]
geno_file = args[2]
gcta_sig_file = args[3]
outpath = args[4]
setwd(outpath)


pheno = read.table(pheno_file,header=TRUE,as.is=TRUE)
gcta_sig = read.table(gcta_sig_file,header=TRUE,as.is=TRUE)
gene_list = unique(gcta_sig[,1])
pheno = pheno[,c(1,2,which(colnames(pheno) %in% gene_list))]
geno = read.table(geno_file,header=TRUE,as.is=TRUE)
fixed = "sex"
# Kinship matrix for the covariance between lines due to a polygenic effect. If not passed, it is calculated from the markers using A.mat.
out = GWAS(pheno=pheno,geno=geno,fixed=fixed,n.core=1,plot=FALSE)
write.table(out,file="rrblup.gwas.output.txt",sep="\t",quote=FALSE)