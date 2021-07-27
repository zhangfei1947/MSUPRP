
total_AS_dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf
anno_AS_dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/02.annogtf
gene_list_file=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter/remain_gene.list
AS_stat_dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/03.AS_stat
PSI_dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/04.PSI

python 02.AS_stat_PSI.py  $total_AS_dir  $anno_AS_dir  $gene_list_file  $AS_stat_dir  $PSI_dir