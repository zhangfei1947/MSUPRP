#!/bin/bash --login

wkdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability
rrblupexp=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability/rrBLUP.genetpm.txt
rrblupas=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability/rrBLUP.AS.txt
rmatsdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.ASdetection/01.mergegtf
ASgene=${wkdir}/AS_gene.txt
exp_as_h=gene_expr_splice.h2.txt

#`sed '1d' ${rmatsdir}/A3SS.MATS.JC.txt|awk '{gsub("\"","",$2);print"A3SS_"$1"\t"$2}' >$ASgene`
#`sed '1d' ${rmatsdir}/A5SS.MATS.JC.txt|awk '{gsub("\"","",$2);print"A5SS_"$1"\t"$2}' >>$ASgene`
#`sed '1d' ${rmatsdir}/MXE.MATS.JC.txt|awk '{gsub("\"","",$2);print"MXE_"$1"\t"$2}' >>$ASgene`
#`sed '1d' ${rmatsdir}/RI.MATS.JC.txt|awk '{gsub("\"","",$2);print"RI_"$1"\t"$2}' >>$ASgene`
#`sed '1d' ${rmatsdir}/SE.MATS.JC.txt|awk '{gsub("\"","",$2);print"SE_"$1"\t"$2}' >>$ASgene`


Rscript 05.combine_expression_h2_splicing_h2.plot.prepare.R $wkdir $rrblupexp $rrblupas $ASgene $exp_as_h

Rscript 05.combine_expression_h2_splicing_h2.plot.R $wkdir $exp_as_h