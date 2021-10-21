
##
##
library(stringi)
args <- commandArgs(trailingOnly=TRUE)
qtl_res_file = args[1]
gene_loc_file = args[2]
outdir = args[3]
setwd(outdir)

qtl_res = read.table(qtl_res_file,header=TRUE,as.is=TRUE)  #gene    chr     strand  start   end     snpchr  snp     pos     pvalue  FDR
gene_list = unique(qtl_res[,"gene"])
gene_loc = read.table(gene_loc_file,header=TRUE,as.is=TRUE,row.names=1)  #geneID	chr	strand	start	end	TSS	TES	exon

outdata = as.data.frame(matrix(data=0,nrow=nrow(qtl_res),ncol=10))  #1diff_chr, 2samechr_far, 3samechr_near, 4exon, 5intron, 6TSS_distance, 7TES_distance 8gene/AS 9SNP 10intron_distance 
outdata[,1] = 1 #default is diff chr
outdata[,6:7] = NA #fefault TSS_d TES_d is NA 
outdata[,10] = NA

idx = 1

for (geneid in gene_list){
#	print(geneid)
	loc = as.list(gene_loc[geneid,]) #1chr     2strand  3start   4end     5TSS     6TES     7exon
#	print(class(loc[[1]]))
#	print(loc[[3]])
#	print(loc[[4]])
	exons = rep(0,loc[[4]]-loc[[3]]+1) #intron 0, exon 1
	es = stri_sub(loc[[7]],1,-2)
	es = unlist(strsplit(es, ";"))
	for (ies in es){
		ies = as.numeric(unlist(strsplit(ies, ",")))
		l = ies[2]-ies[1]+1
		before = ies[1]-loc[[3]]
		after = loc[[4]] - ies[2]
		iies = c(rep(0,before),rep(1,l),rep(0,after))
		exons = exons+iies
	}
	exons[which(exons>0)] = 1
	qtls = qtl_res[which(qtl_res[,"gene"]==geneid),]
#	print(dim(qtls))
	for (i in 1:nrow(qtls)){
		pheno = qtls[i,1]
		outdata[idx,8] = pheno
		snp = qtls[i,"snp"]
		outdata[idx,9] = snp
		snpchr = as.character(qtls[i,"snpchr"])
		if (snpchr=="23"){snpchr="X"}
#		print(class(snpchr))
		snppos = qtls[i,"pos"]
#		print(snppos)
		if (snpchr == loc[[1]]){ # SAME CHR
			outdata[idx,1] = 0 #diff chr is 1; same chr --> 0
			if (snppos >= loc[[3]] && snppos <= loc[[4]]){ # SAME CHR + IN GENE
				pos = snppos-loc[[3]]+1
				if (exons[pos] == 1){# exon/intron
					outdata[idx,4] = 1
				} else {
					outdata[idx,5] = 1
					intron_left = 0
					intron_right = 0
					while (exons[pos-intron_left]==0){intron_left = intron_left+1}  #find intron distance
					while (exons[pos+intron_right]==0){intron_right = intron_right+1}
					print(intron_left)
					print(intron_right)
					print("---")
					if (loc[[2]] == "+"){outdata[idx,10] = intron_left*10/(intron_left+intron_right)} else {outdata[idx,10] = intron_right*10/(intron_left+intron_right)}
				}
				if (loc[[2]] == "+"){
					TSS_d = snppos - loc[[5]] #5 - 10; 8; 8-5=3,8-10=-2,
					TES_d = snppos - loc[[6]]
					if (abs(TSS_d) < abs(TES_d)){outdata[idx,6] = TSS_d} else {outdata[idx,7] = TES_d}
				}else{
					TSS_d = -(snppos - loc[[5]]) #5 - 10; 8; -(8-10)=2, 
					TES_d = -(snppos - loc[[6]])
					if (abs(TSS_d) < abs(TES_d)){outdata[idx,6] = TSS_d} else {outdata[idx,7] = TES_d}
				}
			}else if (abs(snppos-loc[[3]])<1000000 ||  abs(snppos-loc[[4]])<1000000){ # SAME CHR + OFF GENE NEAR
				outdata[idx,3] = 1
				if (loc[[2]] == "+"){
					TSS_d = snppos - loc[[5]] #5 - 10; 8; 8-5=3,8-10=-2,
					TES_d = snppos - loc[[6]]
					if (abs(TSS_d) < abs(TES_d)){outdata[idx,6] = TSS_d} else {outdata[idx,7] = TES_d}
				}else{
					TSS_d = -(snppos - loc[[5]]) #5 - 10; 8; -(8-10)=2, 
					TES_d = -(snppos - loc[[6]])
					if (abs(TSS_d) < abs(TES_d)){outdata[idx,6] = TSS_d} else {outdata[idx,7] = TES_d}
				}
			}else{ #SAME CHR + OFF GENE FAR
				outdata[idx,2] = 1
			}
		}
		idx = idx + 1
	}
}

write.table(outdata,file="plot.qtls.distri.tmp.txt",sep="\t",quote=FALSE,row.names=FALSE,col.names=FALSE)