#!/bin/bash --login
export PATH="/mnt/home/zhangf37/miniconda2/bin:$PATH"

asrrblup=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability/rrBLUP.AS.txt
psidir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/04.PSI
rmatsdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf
sashimidir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability/03.high_h2_sashimi
bamdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/01.Mapping/01.hisat2_mapping

#python 04.high.h2.sashimi.plot.prepare.py $asrrblup $psidir $rmatsdir $sashimidir $bamdir 
#sleep 0.5s
cd $sashimidir
sh high_h2_AS_sashimi_plot.sh
