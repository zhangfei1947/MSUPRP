##prepare plink files
##prepare phenotype file and fixed file
##make sure sample IDs are match

library(bestNormalize)

map = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/map.txt",header=T,as.is=TRUE)
geno = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/SNP.txt",header=T,row.names=1)
genetpm = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/04.tpm_filter/gene_tpm_distri/gene.tpm.distri.filter.for.eQTL.txt",header=TRUE,row.names=1)
sex = read.table("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/sex.txt",header=FALSE,as.is=TRUE)
outdir = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL"
setwd(outdir)

# geno  remove 1833 sample
drops = c("X1833")
geno = geno[,!(names(geno) %in% drops)]

## PLINK files

make_plink=function(outfile,map,M)
{
  library(snpStats)
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

##phenotype gene TPM nqt 
sample_id = read.table("msuprp.fam",header=FALSE,row.names=1)
genetpm = genetpm[,-c(which(colnames(genetpm)=="X1833"))]  #exclude X1833 sample
genetpm = genetpm[,1:143]	#exclude statistics like: SE skewness ...
sample_id = sample_id[colnames(genetpm),]  # add sample is same as plink output
# Normal quantile transformation
nqt_row <- function(row){
    obj = orderNorm(row)
    predict(obj)
}
genetpm = apply(genetpm, 1, nqt_row)
genetpm = round(genetpm,3)

sampleid = sample_id[,1]
genetpm = cbind(sampleid, genetpm)
write.table(genetpm,file="genetpm.nqt.gcta.pheno.txt",quote=F,sep="\t",row.names = TRUE,col.names = FALSE)
write.table(genetpm,file="genetpm.nqt.gcta.pheno.txt.withheader",quote=F,sep="\t",row.names = TRUE,col.names = TRUE)

## fixed file
rownames(sex) = sex[,1]
sex = sex[rownames(sample_id),]
sex = cbind(sex[,1],sample_id[,1],sex[,2])
write.table(sex,file="fixed.txt",quote=F,sep="\t",row.names=FALSE,col.names=FALSE)