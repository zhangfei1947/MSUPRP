##prepare files for gcta sQTL mapping

cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL
## plink file, grm, sparse grm, fixed: same as eQTL
cp /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/msuprp* .
cp /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/sp_msuprp* .
cp /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/fixed.txt .

## phenotype file: pooled AS PSI nqt

Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/04.prepare.sQTL.pheno.r