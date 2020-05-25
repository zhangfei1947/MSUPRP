WORKDIR=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.HISAT2/24sample_PE100
for SAMPLE in `ls ${WORKDIR}/*sam|awk -F '/' '{print$9}'|awk -F '_' '{print$1}'|uniq`
do
    FILES=`ls ${WORKDIR}/${SAMPLE}*sam|awk '{ORS=",";print$1}'`
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",FILES="$FILES",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 3G -J sambam sam2bam.job
    sbatch --export=SAMPLE="$SAMPLE",FILES="$FILES",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 3G -J sambam sam2bam.job
    sleep 1s
done

WORKDIR=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.HISAT2/144sample_stranded_PE125
for SAMPLE in `ls ${WORKDIR}/*sam|awk -F '/' '{print$9}'|awk -F '_' '{print$1}'|uniq`
do
    FILES=`ls ${WORKDIR}/${SAMPLE}*sam|awk '{ORS=",";print$1}'`
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",FILES="$FILES",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 3G -J sambam sam2bam.job
    sbatch --export=SAMPLE="$SAMPLE",FILES="$FILES",WORKDIR="$WORKDIR" -t 2:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 3G -J sambam sam2bam.job
    sleep 1s
done
