
for n in {172..200}
do
	## prepare permute dir and files
	dir=/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL
	cd $dir
	wkdir=permut_$(printf "%04d" $n)
	mkdir -p $wkdir
	cd $wkdir
	ln -s ../msuprp.* .
	ln -s ../sp_msuprp.grm* .
	ln -s ../fixed.txt .
	
	## prepare (shuffled) phenotypes (1: yes shuffle, 6: split to four parts)
	`Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/05.shuffle.split.pheno.r 1 15`
	
	## prepare scripts to gcta and sbumit
	phenofile_list=`ls genetpm.nqt.gcta.pheno.txt.*.names|awk '{ORS=",";print$0}'`
	python /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/05.mappingQTL/06.generate.multiple.gcta.cmd.permutation.py ${phenofile_list} ${dir}/${wkdir}
	
	sbatch -t 4:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 4G -J xxx multiple.gcta.sh
	sleep 4m
done
