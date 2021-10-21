library(ggplot2)
args <- commandArgs(trailingOnly=TRUE)
qtl_res_file = args[1]
pheno_file = args[2]
geno_file = args[3]
outdir = args[4]
setwd(outdir)

qtl_res = read.table(qtl_res_file,header=TRUE,row.names=NULL,as.is=TRUE)
qtl_res = qtl_res[,c(1,which(colnames(qtl_res)=="snp"))]
pheno = read.table(pheno_file,header=TRUE,row.names=1)  #row:sample   col:gene
geno = read.table(geno_file,header=TRUE,row.names=1)  #row:SNP   col:sample 
samples = rownames(pheno)
geno = geno[,samples]


geno_pheno_plot = function(x){
	snp = x[2]
	gene = x[1]
	genotype <- geno[snp,]
	phenotype = pheno[,gene]
    g0 <- as.data.frame(phenotype[genotype==0])
    g0$genotype <- rep("g0", length(g0[,1]))
    g1 <- as.data.frame(phenotype[genotype==1])
    g1$genotype <- rep("g1", length(g1[,1]))
    g2 <- as.data.frame(phenotype[genotype==2])
    g2$genotype <- rep("g2", length(g2[,1]))
    colnames(g0) <- c("phenotype","genotype")
    colnames(g1) <- c("phenotype","genotype")
    colnames(g2) <- c("phenotype","genotype")
    plotdata <- rbind(g0,g1,g2)
    p <- ggplot(plotdata,aes(x=genotype,y=phenotype)) + geom_boxplot(outlier.shape=NA,aes(colour=genotype)) + geom_jitter(height=2,aes(colour=genotype))
    ggsave(file=paste0(gene,"_",snp,".jitter.png"),plot=p)
}

apply(qtl_res, 1, geno_pheno_plot)
