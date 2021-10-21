
gtffile=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge/stringtie_merge.gtf
transcriptfile=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter/all_sample_transcript_filtered.txt
outdir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter
python 04.03.mergegtf_filter.py $gtffile $transcriptfile $outdir