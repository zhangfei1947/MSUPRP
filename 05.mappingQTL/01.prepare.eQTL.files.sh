
Rscript 01.prepare.eQTL.plink.pheno.fixed.r

cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL
## gcta claculate GRM
#calculate GRM
gcta64  --bfile msuprp  --autosome-num 18  --make-grm  --out msuprp
# make sparse GRM
gcta64 --grm msuprp --make-bK-sparse 0.05 --out sp_msuprp