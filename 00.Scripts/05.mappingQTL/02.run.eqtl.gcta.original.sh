
## prepare permute dir and files
dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL
cd $dir
wkdir=original
mkdir -p $wkdir
cd $wkdir
ln -s ../msuprp.* .
ln -s ../sp_msuprp.grm* .
ln -s ../fixed.txt .

## prepare (shuffled) phenotypes
`Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/02.shuffle.split.pheno.r 0 4`

## prepare scripts to gcta and sbumit
phenofile_list=`ls genetpm.nqt.gcta.pheno.txt.*.names|awk '{ORS=",";print$0}'`
python /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/02.generate.multiple.gcta.cmd.py ${phenofile_list} ${dir}/${wkdir}

sbatch -t 4:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 4G -J xxx multiple.gcta.sh


