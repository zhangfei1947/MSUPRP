
genetpmfilter=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter/gene_tpm_distri/gene.tpm.distri.filter.for.eQTL.txt
rmatsdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf
asstat=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/03.AS_stat/AS.stat.txt
psifilteredfiles=`ls -d  /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/*/filter/*PSI.filter.txt|awk '{ORS=",";print}'`
outdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/06.PSIfilter_stat
python 06.PSIfilter_stat.py $genetpmfilter  $rmatsdir  $asstat  $psifilteredfiles $outdir