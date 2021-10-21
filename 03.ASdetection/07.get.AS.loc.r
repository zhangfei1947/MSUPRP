library(stringr)

args = commandArgs(T)
print(args)
AS_list_path = args[1]
AS_detect_path = args[2]
gene_loc_file = args[3]
outpath = args[4]
setwd(outpath)

#As list
AS_filter_files = Sys.glob(AS_list_path)
AS_list = c()
for (AS_filter_file in AS_filter_files){
	print(AS_filter_file)
	d = read.table(AS_filter_file,header=TRUE)
	AS_list = c(AS_list, row.names(d))
}

#gene loc
gene_loc = read.table(gene_loc_file,header=TRUE,row.names=1)


AS_loc = NA
AS_detect_files = Sys.glob(AS_detect_path)
for (AS_detect_file in AS_detect_files){
	print(AS_detect_file)
	#read AS events, extract start and end
	AStype = str_split(AS_detect_file,"/")[[1]][9]
	AStype = str_split(AStype,"\\.")[[1]][1]
	print(AStype)
	d = read.table(AS_detect_file,header=TRUE,sep="\t",as.is=TRUE)
	d$ID = paste0(AStype, "_", as.character(d[,1]))
#	print(colnames(d))
	if (grepl("SS", AStype, fixed=TRUE)){
		dd = d[,c("ID", "GeneID", "longExonStart_0base", "longExonEnd")]
		colnames(dd) = c("ASID","geneID","ASstart","ASend")
	}else{
		dd = d[,c("ID","GeneID", "upstreamEE", "downstreamES")]
		colnames(dd) = c("ASID","geneID","ASstart","ASend")
	}
	#extract AS in list
	rownames(dd) = dd[,1]
	common_AS_id = intersect(dd[,1],AS_list)
	dd = dd[common_AS_id,]
	print(head(dd))
	#add gene loc
	gene_loc_tmp = gene_loc[dd$geneID,]
	print(head(gene_loc_tmp))
	print(dim(dd))
	print(dim(gene_loc_tmp))
	dd = cbind(dd[1:2],gene_loc_tmp,dd[,3:4])
	AS_loc = rbind(dd,AS_loc)
}

write.table(AS_loc,file="AS.loc.txt",col.names=TRUE,row.names=FALSE,sep="\t",quote=FALSE)

