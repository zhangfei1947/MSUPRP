chr_len_file = "/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Chr.length"
QTL_res_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/07.ModelSelection/sQTL/QTL.results.txt"
modelselect_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sqtl.model.selection"

QTL_res = read.table(QTL_res_file,header=TRUE,as.is=TRUE)
modelselect = read.table(modelselect_file,header=FALSE,as.is=TRUE)
QTL_res_genesnp = paste0(QTL_res$gene,QTL_res$snp)
modelselect_genesnp = paste0(modelselect[,1],modelselect[,2])
QTL_res = QTL_res[which(QTL_res_genesnp %in% modelselect_genesnp),]

write.table(QTL_res,file="QTL.results.txt.modelselect",col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")

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


#QTL_res = read.table(QTL_res_file,header=TRUE,as.is=TRUE)
QTL_res$AS_pos = (QTL_res$ASstart+QTL_res$ASend)/2

QTL_res$QTLtype = "trans"

for(i in 1:nrow(QTL_res)) {
    if ((QTL_res[i,3]==QTL_res[i,10]) & (abs(QTL_res[i,12]-QTL_res[i,15])<1000000)) {
        QTL_res[i,16] = "cis"
    }
    QTL_res[i,12] = QTL_res[i,12] + chr_len_add[QTL_res[i,10],1]
    QTL_res[i,15] = QTL_res[i,15] + chr_len_add[QTL_res[i,3],1]
}

QTL_res_out = QTL_res[,c("AS_pos","pos","QTLtype")]
write.table(QTL_res_out, file="ASpos.snppos.type.txt", col.names=TRUE,row.names=FALSE,quote=FALSE,sep="\t")
