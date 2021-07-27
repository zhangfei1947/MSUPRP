#!/bin/bash
WORKDIR=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping

for SAMPLE in `ls ${WORKDIR}/*sam|awk -F '/' '{print$9}'|awk -F '_' '{print$1}'|uniq`
do
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 5G -J sambam 02.sam2bam.job
    sbatch --export=SAMPLE="$SAMPLE",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 5G -J sambam 02.sam2bam.job
    sleep 0.5s
done
