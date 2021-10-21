##parameters:  1.modelselection result file  2.fastGWA files path 3.output path

echo eQTL
#Rscript 01.manhattanplot.r \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/01.eQTL/eqtl.model.selection \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/original \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/01.eQTL/manhattan_plot
 
echo sQTL 
Rscript 01.manhattanplot.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL/sqtl.model.selection \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/original \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL/manhattan_plot
