

#echo eQTL
#Rscript 12.plot.pheno.geno.beforenqt.r \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTL.results.pval.1e-20.txt  \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter/gene_tpm_distri/gene.tpm.distri.filter.for.eQTL.txt \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/SNP.txt  \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/pheno_geno_plot_beforenqt
  
  
echo sQTL
Rscript 12.plot.pheno.geno.beforenqt.r  \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTL.results.pval.1e-20.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/combine.filtered.AS.PSI.txt  \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/SNP.txt  \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/pheno_geno_plot_beforenqt