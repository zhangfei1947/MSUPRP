#!/bin/bash --login
export PATH="/mnt/home/zhangf37/miniconda2/bin:$PATH"

python /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/09.calculate.permutation.sQTL.FDR.py \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/original \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/permut_ 