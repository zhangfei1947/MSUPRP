#!/bin/bash --login
export PATH="/mnt/home/zhangf37/miniconda2/bin:$PATH"

## parameters:		pheno.rrblup.txt		geno.rrblup.txt		QTL.results.pval.1e-20.txt		outpath

#Rscript 14.compare.gcta.rrblup.pval.r \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/compare_gcta_rrblup/pheno.rrblup.txt \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/compare_gcta_rrblup/geno.rrblup.txt \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTL.results.pval.1e-20.txt \
#  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/compare_gcta_rrblup


Rscript 14.compare.gcta.rrblup.pval.r \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/compare_gcta_rrblup/pheno.rrblup.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/compare_gcta_rrblup/geno.rrblup.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTL.results.pval.1e-20.txt \
  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/compare_gcta_rrblup