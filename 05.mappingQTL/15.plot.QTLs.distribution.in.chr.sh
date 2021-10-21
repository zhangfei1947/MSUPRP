
echo eqtl
Rscript 15.plot.QTLs.distribution.in.chr.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTL.results.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr/gene.detailed.location.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr
  
echo sqtl
Rscript 15.plot.QTLs.distribution.in.chr.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTL.results.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr/gene.detailed.location.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTLs_distribution_in_chr
