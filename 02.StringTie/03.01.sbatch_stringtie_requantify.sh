OUTPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/03.requantify
BAMPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping

for SAMPLE in `ls ${BAMPATH}/*.sort.bam|awk -F '/' '{print $NF}'|awk -F '.' '{print$1}'`
do
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",BAMPATH="$BAMPATH" -t 1:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 4G -J stringtie 03.01.stringtie_requantify.job
    sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",BAMPATH="$BAMPATH" -t 1:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 4G -J stringtie 03.01.stringtie_requantify.job
    sleep 0.2s
done