
tracking=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge/mergegtf_compare.tracking
requantdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/03.requantify
outdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter

#python 04.02.stringtie_gtf_extract_tpm.py ${requantdir}
Rscript 04.02.transcript_tpm_merge_filter.R ${tracking} ${requantdir} ${outdir}