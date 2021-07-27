
#SE  RI  MXE  A5SS  A3SS
psipath=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/04.PSI
out=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/05.PSI_filter
sexfile=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/fixed.effects.txt

AStype=SE
psi=${psipath}/${AStype}.PSI.txt
outpath=${out}/${AStype}
Rscript 05.PSI_filter.R  $AStype  $psi  $outpath  $sexfile


AStype=RI
psi=${psipath}/${AStype}.PSI.txt
outpath=${out}/${AStype}
Rscript 05.PSI_filter.R  $AStype  $psi  $outpath  $sexfile

AStype=MXE
psi=${psipath}/${AStype}.PSI.txt
outpath=${out}/${AStype}
Rscript 05.PSI_filter.R  $AStype  $psi  $outpath  $sexfile

AStype=A5SS
psi=${psipath}/${AStype}.PSI.txt
outpath=${out}/${AStype}
Rscript 05.PSI_filter.R  $AStype  $psi  $outpath  $sexfile

AStype=A3SS
psi=${psipath}/${AStype}.PSI.txt
outpath=${out}/${AStype}
Rscript 05.PSI_filter.R  $AStype  $psi  $outpath  $sexfile

