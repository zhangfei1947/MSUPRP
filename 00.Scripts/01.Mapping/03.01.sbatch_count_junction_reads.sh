#!/bin/bash
#count the junction mapped reads. For multiple mapping, we only count hte primary mapping, ignore all "Not primary alignment" alignment flag 256

bamdir="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping"
statdir="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/02.mapping_stat"


echo "sample mapped_reads junction_mapped junction_map_rate" > ${statdir}/junction_mapping_reads_stat.txt
for sample in `ls ${bamdir}/[0-9][0-9][0-9][0-9].sort.bam|awk -F '/' '{print $NF}'|awk -F '.' '{print$1}'`
do
	echo $sample
	echo sbatch --export=sample="$sample",bamdir="$bamdir",statdir="$statdir" -t 1:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 1G -J junct 03.01.count_junction_reads.job
    sbatch --export=sample="$sample",bamdir="$bamdir",statdir="$statdir" -t 1:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 1G -J junct 03.01.count_junction_reads.job
    sleep 0.5s
done