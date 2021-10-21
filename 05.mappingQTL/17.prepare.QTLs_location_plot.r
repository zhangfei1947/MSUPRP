
chr_len_file = "/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Chr.length"
QTL_res_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_location_plot/QTL.results.txt.fdr0.01.autosome"

chr_len = read.table(chr_len_file,header=FALSE,as.is=TRUE)
chr_len = chr_len[1:18,]
chr_len[,2] = as.numeric(chr_len[,2])
chr_len = chr_len[order(chr_len[,2]),]

chr_len_add = chr_len
chr_len_add[,1] = 0
for (i in 1:18){
	for (j in 1:i){
		chr_len_add[i,1] = chr_len_add[i,1] + chr_len[j,1]
	}
}

chr_len_add[,1] = chr_len_add[,1] - chr_len[,1]


QTL_res = read.table(QTL_res_file,header=TRUE,as.is=TRUE)
QTL_res$gene_pos = (QTL_res$start+QTL_res$end)/2

QTL_res$QTLtype = "trans"

for(i in 1:nrow(QTL_res)) {
	if ((QTL_res[i,2]==QTL_res[i,6]) & (abs(QTL_res[i,8]-QTL_res[i,11])<1000000)) {
		QTL_res[i,12] = "cis"
	}
	QTL_res[i,8] = QTL_res[i,8] + chr_len_add[QTL_res[i,6],1]
	QTL_res[i,11] = QTL_res[i,11] + chr_len_add[QTL_res[i,2],1]
}

QTL_res_out = QTL_res[,c("gene_pos","pos","QTLtype")]
write.table(QTL_res_out, file="genepos.snppos.type.txt", col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")