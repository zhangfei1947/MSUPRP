for SAMPLE in `ls /mnt/research/qgg/msuprp/20141124_mRNASeq_PE/raw|awk -F '_' '{print$1"_"$2"_"$3}'|sort|uniq`
do
    FILENAME1=`ls /mnt/research/qgg/msuprp/20141124_mRNASeq_PE/raw/*${SAMPLE}*R1*`
    FILENAME2=`ls /mnt/research/qgg/msuprp/20141124_mRNASeq_PE/raw/*${SAMPLE}*R2*`
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",FILENAME1="$FILENAME1",FILENAME2="$FILENAME2" -t 1:00:00 -N 1 -n 2 -c 1 --mem-per-cpu 3G -J HISAT2 01.hisat2.job
    sbatch --export=SAMPLE="$SAMPLE",FILENAME1="$FILENAME1",FILENAME2="$FILENAME2" -t 1:00:00 -N 1 -n 2 -c 1 --mem-per-cpu 3G -J HISAT2 01.hisat2.job
    sleep 0.2s
done


for SAMPLE in `ls /mnt/research/qgg/msuprp/20141230_mRNASeq_PE/raw|awk -F '_' '$1!="1091" && $1!="1152" && $1!="1239" && $1!="1423" && $1!="1456" && $1!="1533" && $1!="1646" && $1!="1760"{print$1"_"$2"_"$3}'|sort|uniq`
do
    FILENAME1=`ls /mnt/research/qgg/msuprp/20141230_mRNASeq_PE/raw/*${SAMPLE}*R1*`
    FILENAME2=`ls /mnt/research/qgg/msuprp/20141230_mRNASeq_PE/raw/*${SAMPLE}*R2*`
    echo ${SAMPLE}
    echo sbatch --export=SAMPLE="$SAMPLE",FILENAME1="$FILENAME1",FILENAME2="$FILENAME2" -t 1:00:00 -N 1 -n 2 -c 1 --mem-per-cpu 3G -J HISAT2 01.hisat2.job
    sbatch --export=SAMPLE="$SAMPLE",FILENAME1="$FILENAME1",FILENAME2="$FILENAME2" -t 1:00:00 -N 1 -n 2 -c 1 --mem-per-cpu 3G -J HISAT2 01.hisat2.job
    sleep 0.2s
done

