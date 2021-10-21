chr_len_file = "/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Chr.length"
QTL_res_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTL.results.txt.FDR0.01"
modelselect_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL/sqtl.model.selection"
outpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL"
setwd(outpath)

QTL_res = read.table(QTL_res_file,header=TRUE,as.is=TRUE)
modelselect = read.table(modelselect_file,header=FALSE,as.is=TRUE)
QTL_res_genesnp = paste0(QTL_res$AS,QTL_res$snp)
modelselect_genesnp = paste0(modelselect[,1],modelselect[,2])
#filter with model select results
QTL_res = QTL_res[which(QTL_res_genesnp %in% modelselect_genesnp),]
#Only retain autosome
QTL_res = QTL_res[which(QTL_res$chr %in% c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18")),]
QTL_res = QTL_res[which(QTL_res$snpchr %in% c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18")),]
QTL_res$chr = as.numeric(QTL_res$chr)
QTL_res$snpchr = as.numeric(QTL_res$snpchr)
#write.table(QTL_res,file="QTL.results.txt.modelselect",col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")

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
print(chr_len_add)


#QTL_res = read.table(QTL_res_file,header=TRUE,as.is=TRUE)
QTL_res$gene_pos = (QTL_res$ASstart+QTL_res$ASend)/2

QTL_res$QTLtype = "trans"

#1AS 2gene 3chr 4strand 5start 6end 7expand 8ASstart 9ASend 10snpchr 11snp  12pos  13pvalue 14FDR 15gene_pos 16QTLtype

for(i in 1:nrow(QTL_res)) {
    if ((QTL_res[i,3]==QTL_res[i,10]) & (abs(QTL_res[i,12]-QTL_res[i,15])<1000000)) {
        QTL_res[i,16] = "cis"
    }
    QTL_res[i,15] = QTL_res[i,15] + chr_len_add[QTL_res[i,3],1]
    QTL_res[i,12] = QTL_res[i,12] + chr_len_add[QTL_res[i,10],1]
}

QTL_res_out = QTL_res[,c("gene_pos","pos","QTLtype")]
write.table(QTL_res_out, file="genepos.snppos.type.txt", col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")
write.table(QTL_res,file="QTL.results.txt.modelselect",col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")
