##model selection
library(snpStats)


allpheno_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/genetpm.nqt.gcta.pheno.txt.withheader"
sig_gene_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/eQTL.sig.genes"

map = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/map.txt",header=T,as.is=TRUE)
geno = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/SNP.txt",header=T,row.names=1)
sex = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/sex.txt",header=FALSE,as.is=TRUE)

outpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/03.eQTL.modelSelection"
setwd(outpath)

# geno  remove 1833 sample
drops = c("X1833")
geno = geno[,!(names(geno) %in% drops)]


##prepare pheno file for model selection 
genes = read.table(sig_gene_file,header=FALSE)[,1]
allpheno = read.table(allpheno_file,header=TRUE,row.names=1)
selected_pheno = allpheno[,c(1,which(colnames(allpheno) %in% genes))]

write.table(selected_pheno,file="selected.pheno.txt",col.names=FALSE,row.names=TRUE,sep="\t",quote=FALSE)
rm(allpheno,selected_pheno)




trans_snp_to_fix = function(snp,geno,fixed){
	snp = geno$snp
	fixed = cbind(fixed,snp)
	write.table(fixed,file="fixed.txt",quote=F,sep="\t",row.names=FALSE,col.names=FALSE)
}



cal_GRM = function(){
	system("gcta64  --bfile msuprp  --autosome-num 18  --make-grm  --out msuprp")
	system("gcta64 --grm msuprp --make-bK-sparse 0.05 --out sp_msuprp")
}



make_plink=function(outfile,map,M)
{
  SNP=new("SnpMatrix",t(M)+1)
  counter=ncol(M)

  # .fam file
  # family ID, individual ID, ID of father (-9 missing), of mother (-9 missing), sex (1 male, 2 female, 0 unknown), phenotype (-9 for missing)
  id=1:counter
  ped=rownames(SNP) # or family ID
  ped=gsub(" ","",ped)

  # .bim file
  # chromosome, snp id, position in centimorgans (0 for missing), position, ALT allele, REF allele
  one=rep("A",nrow(map)) # reference allele - Minimac only seems to work with ATCG
  two=rep("T",nrow(map)) # alt allele

  y=rep(0,counter) # phenotype

  # write.plink(file.base, snp.major = TRUE, snps, subject.data, pedigree, id, father, mother, sex, phenotype, snp.data, chromosome, genetic.distance, position, allele.1, allele.2, na.code = 0, human.genome=TRUE)
  write.plink(outfile, snps=SNP, pedigree=ped, id=id, phenotype=y, chromosome=map[,2],position=map[,3], allele.1=one, allele.2=two, na.code=-9, human.genome=FALSE)
}

rownames(map) = map[,1]
map = map[c(rownames(geno)),]
make_plink(outfile="msuprp",map,geno)




run_gcta_GWA = function(each_gene, each_gene_idx){
	cmd = paste0("gcta64 --bfile msuprp --grm-sparse sp_msuprp --fastGWA-mlm --pheno selected.pheno.txt --mpheno ", each_gene_idx, " --covar fixed.txt --threads 1 --out ", each_gene)
	system(cmd)
}




check_fastGWA_res = function(each_gene){
	fastGWA_file = paste0(each_gene,".fastGWA")
	snp = "xxxx"
	return(TRUE/FALSE)
}




wrap_up_gene_res = function(each_gene){
	
}




each_gene_idx = 0
for (each_gene in genes){
	print(each_gene)
	snp = NA
	each_gene_idx = each_gene_idx + 1
	while(TRUE){
		trans_snp_to_fix()
		make_plink()
		cal_GRM()
		run_gcta_GWA(each_gene, each_gene_idx)
		if (!check_fastGWA_res(each_gene)){break}
	}
	wrap_up_gene_res(each_gene)
}
