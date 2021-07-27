##parameters:  1.gene_SNP_count file	2.fastGWA files path	3.output path

echo eQTL
Rscript 13.manhattan.qq.plot.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTL.results.gene_SNP_count.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/original \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/manhattan_qq
 
echo sQTL 
Rscript 13.manhattan.qq.plot.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTL.results.AS_SNP_count.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/original \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/manhattan_qq