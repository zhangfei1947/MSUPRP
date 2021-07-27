#!/bin.bash
#Argument: summary_dir, stat_dir, count_junction_stat file

python 03.02.mapping_stat.py \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/02.mapping_stat \
 /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/02.mapping_stat/junction_mapping_reads_stat.txt \
 > 03.02.mapping_stat.log
 
 