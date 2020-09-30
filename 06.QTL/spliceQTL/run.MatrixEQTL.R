library(MatrixEQTL)

args <- commandArgs(trailingOnly=TRUE)
type <- args[1]  # SE MXE ...

base.dir = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL"
SNP_file_name = paste0(base.dir,"/SNP.txt");
snps_location_file_name = paste0(base.dir,"/snploc.txt");

expression_file_name = paste0("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.Heritability/AS_Heritability/",type,"_PSI.nqt");
gene_location_file_name = paste0("/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.AlternativeSplicing/merge_gtf/",type,".loc.txt");

covariates_file_name = paste0(base.dir,"/Covariates.01.txt");

output_file_name_cis = tempfile();
output_file_name_tra = tempfile();

pvOutputThreshold_cis = 2e-2;
pvOutputThreshold_tra = 1e-2;

errorCovariance = numeric();

cisDist = 1e6;

useModel = modelLINEAR;


#snp
snps = SlicedData$new();

snps$fileDelimiter = "\t";

snps$fileOmitCharacters = "NA";

snps$fileSkipRows = 1;

snps$fileSkipColumns = 1;

snps$fileSliceSize = 2000;

snps$LoadFile(SNP_file_name);


#GE PSI
gene = SlicedData$new();

gene$fileDelimiter = "\t";

gene$fileOmitCharacters = "nan";

gene$fileSkipRows = 1;

gene$fileSkipColumns = 1;

gene$fileSliceSize = 2000;

gene$LoadFile(expression_file_name);


#covariate
cvrt = SlicedData$new();

cvrt$fileDelimiter = "\t";

cvrt$fileOmitCharacters = "NA";

cvrt$fileSkipRows = 1;

cvrt$fileSkipColumns = 1;

if(length(covariates_file_name)>0) {

 cvrt$LoadFile(covariates_file_name);

}


#gene~snp
snpspos =read.table(snps_location_file_name, header = TRUE, stringsAsFactors = FALSE);

genepos =read.table(gene_location_file_name, header = TRUE, stringsAsFactors = FALSE);



##analysis
me = Matrix_eQTL_main(

    snps = snps,

    gene = gene,

    cvrt = cvrt,

    output_file_name = output_file_name_tra,

    pvOutputThreshold = pvOutputThreshold_tra,

    useModel = useModel,

    errorCovariance = errorCovariance,

    verbose = TRUE,

    output_file_name.cis  =output_file_name_cis,

    pvOutputThreshold.cis =pvOutputThreshold_cis,

    snpspos = snpspos,

    genepos = genepos,

    cisDist = cisDist,

    pvalue.hist = TRUE,

    min.pv.by.genesnp = FALSE,

    noFDRsaveMemory= FALSE);


#show(me$cis$eqtls)
write.table(me$cis$eqtls, file=paste0(type,".cis.eqtl.xls"), quote=F, sep="\t", col.names=TRUE)

#show(me$trans$eqtls)
write.table(me$trans$eqtls, file=paste0(type,".trans.eqtl.xls"), quote=F, sep="\t", col.names=TRUE)

plot(me)



