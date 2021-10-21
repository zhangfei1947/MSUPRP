
#AS_list_path="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/\*/filter/\*.PSI.filter.txt"
#AS_detect_path="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf/\*.MATS.JC.txt"
#gene_loc_file="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge/gene_loc.txt"
#outpath="/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/03.AS_stat"

Rscript 07.get.AS.loc.r \
 "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter/*/filter/*.PSI.filter.txt" \
 "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf/*.MATS.JC.txt" \
 "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge/gene_loc.txt" \
 "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/03.AS_stat"