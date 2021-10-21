##parameters:  1.modelselection result file	 2.fastGWA files path	3.output path

library(data.table)
library(qqman)
args <- commandArgs(trailingOnly = TRUE)
modelselect_file = args[1]
fastGWA_path = args[2]
outpath = args[3]

setwd(outpath)
modelselect = read.table(modelselect_file, header=FALSE, as.is=TRUE)
colnames(modelselect) = c("gene","snp")
setDT(modelselect)[, snps := paste0(as.character(snp), collapse = ","), by=gene] #gene snp snps
modelselect = unique(modelselect[,c(1,3)])


plot_man_qq = function(onerow){
	gene = onerow[1]
    print(gene)
	snps = unlist(strsplit(onerow[2], ","))
	gwa_file = paste0(fastGWA_path,"/",gene,".fastGWA")
	gwasres = read.table(gwa_file, header=TRUE, as.is=TRUE)
	plot_name = paste0(gene)
	png(paste0(plot_name,".manhattan.png"), width=1000, height=600)
	manhattan(gwasres, chr="CHR", bp="POS", snp="SNP", p="P", highlight=snps)
	dev.off()
}

apply(modelselect, 1, plot_man_qq)
