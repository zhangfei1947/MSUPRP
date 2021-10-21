##parameters:  1.gene_SNP_count file	2.fastGWA files path	3.output path

library(qqman)
args <- commandArgs(trailingOnly = TRUE)
gene_SNP_count_file = args[1]
fastGWA_path = args[2]
outpath = args[3]

setwd(outpath)
gene_SNP_count = read.table(gene_SNP_count_file, header=FALSE, as.is=TRUE)

plot_man_qq = function(onerow){
	gene = onerow[1]
	snpcount = onerow[2]
	gwa_file = paste0(fastGWA_path,"/",gene,".fastGWA")
	gwasres = read.table(gwa_file, header=TRUE, as.is=TRUE)
	plot_name = paste0(snpcount,"_",gene)
	png(paste0(plot_name,".manhattan.png"), width=1000, height=600)
	manhattan(gwasres, chr="CHR", bp="POS", snp="SNP", p="P")
	dev.off()
	png(paste0(plot_name,".qq.png"), width=600, height=600)
	qq(gwasres$P)
	dev.off()
}

apply(gene_SNP_count, 1, plot_man_qq)