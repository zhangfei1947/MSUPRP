##prepare pheno file for model selection 
allpheno_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/genetpm.nqt.gcta.pheno.txt.withheader"
sig_gene_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/eQTL.sig.genes"
outpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/03.eQTL.modelSelection"
setwd(outpath)

genes = read.table(sig_gene_file,header=FALSE)[,1]
allpheno = read.table(allpheno_file,header=TRUE,row.names=1)
selected_pheno = allpheno[,c(1,which(colnames(allpheno) %in% genes))]

write.table(selected_pheno,file="selected.pheno.txt",col.names=FALSE,row.names=TRUE,sep="\t",quote=FALSE)