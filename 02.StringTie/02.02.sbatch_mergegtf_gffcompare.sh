#!/bin/bash

WKPATH=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge

sbatch --export=WKPATH="$WKPATH" -t 4:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 10G -J gffcompare 02.02.mergegtf_gffcompare.job