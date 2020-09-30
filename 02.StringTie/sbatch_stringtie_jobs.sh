OUTPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/24sample_PE100
STRANDED="no"
for SAMPLE in `ls ${OUTPATH}|awk -F '.' '{print$1}'`
do
    echo ${SAMPLE} ${STRANDED}
    echo sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",STRANDED="$STRANDED" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie stringtie.job
    sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",STRANDED="$STRANDED" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie stringtie.job
    sleep 0.5s
done

OUTPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/144sample_stranded_PE125
STRANDED="yes"
for SAMPLE in `ls ${OUTPATH}|awk -F '.' '{print$1}'`
do
    echo ${SAMPLE} ${STRANDED}
    echo sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",STRANDED="$STRANDED" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie stringtie.job
    sbatch --export=SAMPLE="$SAMPLE",OUTPATH="$OUTPATH",STRANDED="$STRANDED" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie stringtie.job
    sleep 0.5s
done
