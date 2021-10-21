
echo eqtl
Rscript 03.plot.QTLs.distribution.in.chr.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/01.eQTL/QTL.results.txt.modelselect \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr/gene.detailed.location.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/01.eQTL
  
echo sqtl
Rscript 03.plot.QTLs.distribution.in.chr.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL/QTL.results.txt.modelselect \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr/gene.detailed.location.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL
