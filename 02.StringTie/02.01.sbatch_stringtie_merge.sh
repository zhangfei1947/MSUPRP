#!/bin/bash

WKPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge
ls /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/01.stringtie_assemble/*.stringtie.gtf|awk '{print$0}' > ${WKPATH}/stringtie_assemble_gtf_list.txt

sbatch --export=WKPATH="$WKPATH" -t 4:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 10G -J merge 02.01.stringtie_merge.job