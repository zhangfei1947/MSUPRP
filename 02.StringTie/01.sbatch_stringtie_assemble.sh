BAMPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping
OUTPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/01.stringtie_assemble

for SAMPLE in `ls ${BAMPATH}/[0-9][0-9][0-9][0-9].sort.bam|awk -F '/' '{print$NF}'|awk -F '.' '{print$1}'`
do
    echo $SAMPLE
    echo sbatch --export=SAMPLE="$SAMPLE",BAMPATH="$BAMPATH",OUTPATH="$OUTPATH" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie 01.stringtie_assemble.job
    sbatch --export=SAMPLE="$SAMPLE",BAMPATH="$BAMPATH",OUTPATH="$OUTPATH" -t 4:00:00 -N 1 -n 4 -c 1 --mem-per-cpu 4G -J stringtie 01.stringtie_assemble.job
    sleep 0.5s
done