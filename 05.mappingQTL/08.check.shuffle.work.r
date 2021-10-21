
##check the shuffle works

shufflefiles = Sys.glob("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/*/genetpm.nqt.gcta.pheno.txt.01")
file_len = length(shufflefiles)

sample_arr_mat = as.data.frame(matrix(data=NA,nrow=file_len,ncol=143))
same_order_num = matrix(data=0,nrow=file_len,ncol=file_len)
i = 1
for (eachfile in shufflefiles){
	d = read.table(eachfile, header=FALSE)
	sample_arr = as.character(d[,2])
	sample_arr_mat[i,] = sample_arr
	if (i>1){
		for (j in 1:(i-1)){
			same_num = sum(sample_arr == sample_arr_mat[j,])
			same_order_num[j,i] = same_num
		}
	}
	
	i = i+1
}

# plot each two pair have same order
pair_same_order = same_order_num[upper.tri(same_order_num, diag=FALSE)]
png("pair_have_same_order.sQTL.png",width=600,height=400)
hist(pair_same_order)
dev.off()
