## /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A3SS/filter/A3SS.PSI.filter.nqt.txt
## /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A5SS/filter/A5SS.PSI.filter.nqt.txt
## /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/MXE/filter/MXE.PSI.filter.nqt.txt
## /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/RI/filter/RI.PSI.filter.nqt.txt
## /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/SE/filter/SE.PSI.filter.nqt.txt

setwd("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL")

a3file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A3SS/filter/A3SS.PSI.filter.nqt.txt"
a5file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/A5SS/filter/A5SS.PSI.filter.nqt.txt"
mxefile = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/MXE/filter/MXE.PSI.filter.nqt.txt"
rifile = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/RI/filter/RI.PSI.filter.nqt.txt"
sefile = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/SE/filter/SE.PSI.filter.nqt.txt"

fixedfile = "fixed.txt"
fixed = read.table(fixedfile,header=FALSE,row.names=1,as.is=TRUE)

data = read.table(a3file,header=TRUE,row.names=1)
data = round(data,3)
data = data[rownames(fixed),]
sampleid = fixed[,1]
data = cbind(sampleid,data)

for (asfile in c(a5file,mxefile,rifile,sefile)){
	d = read.table(asfile,header=TRUE,row.names=1)
	d = round(d,3)
	d = d[rownames(fixed),]
	data = cbind(data,d)
}

write.table(data,file="aspsi.nqt.gcta.pheno.txt.withheader",quote=FALSE,sep="\t",row.names=TRUE,col.names=TRUE)
write.table(data,file="aspsi.nqt.gcta.pheno.txt",quote=FALSE,sep="\t",row.names=TRUE,col.names=FALSE)