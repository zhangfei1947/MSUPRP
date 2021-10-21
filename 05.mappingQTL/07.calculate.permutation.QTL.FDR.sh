#!/bin/bash --login
export PATH="/mnt/home/zhangf37/miniconda2/bin:$PATH"

python /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/07.calculate.permutation.QTL.FDR.py \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/original \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/permut_ 
 