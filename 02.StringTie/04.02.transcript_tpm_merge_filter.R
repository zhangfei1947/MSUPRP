
library(stringr)
args = commandArgs(T) 
tracking = args[1]
requantdir = args[2]
outdir = args[3]
setwd(requantdir)

isotype = read.table(tracking,header=F,sep="\t")
isotype[,5:7] = str_split_fixed(isotype[,5],"\\|",n=3)
isotpm = isotype[,c(6,4)]
colnames(isotpm) = c("transcript","type")
head(isotpm)
#allgtf = list.files(path=".",pattern="*transcript_tpm.txt")
#allgtf = allgtf[-which(allgtf=="1833.transcript_tpm.txt")]  #delete 1833 sample

handle = file("transcript_tpm.txt",open="r")
line = readLines(handle,n=1)
N = length(unlist(strsplit(line,"\t")))
tmp = as.data.frame(matrix(NA,N,0))
close(handle)
handle = file("transcript_tpm.txt",open="r")
n=1
while(TRUE){
	line = readLines(handle,n=1)
	if(length(line) == 0){
		break
	}
	if(n==1){
		tmp[,n] = unlist(strsplit(line,"\t"))
	}else{
		tmp[,n] = as.numeric(unlist(strsplit(line,"\t")))
	}
	print(n)
	n=n+1
}
close(handle)
colnames(tmp) = tmp[1,]
tmp = tmp[-1,]
print(tmp[1:10,1:10])
#tmp = read.table("transcript_tpm.txt",header=T,sep="\t",row.names=1)
#tmp = t(tmp)
isotpm = merge(isotpm,tmp,by="transcript",all=T)
print(isotpm[1:10,1:10])

##
if(FALSE){
for(i in 1:length(allgtf)){
	gtffile = allgtf[i]
	print(gtffile)
	tmp = read.table(gtffile,header=F,sep="\t")
	colnames(tmp) = c("transcript",unlist(strsplit(gtffile, "[.]"))[1])
	isotpm = merge(isotpm,tmp,by="transcript",all=T)
}
print(isotpm[1:10,1:10])
}
##


setwd(outdir)
filter_isotpm = isotpm[0,]
iso_types = c("=","c","k","m","n","j","e","o","s","x","i","y","p","r","u")
type_num = as.data.frame(matrix(NA,length(iso_types),2,dimnames = list(iso_types,c("before","after")))) #before filter; after filter
sample_num = ncol(filter_isotpm)-2
for(isotype in iso_types){
	data = isotpm[isotpm$type==isotype,]
	type_num[isotype,1] = nrow(data)
	#plot
	if(nrow(data)>10){
		png(paste0("iso_",isotype,"_log2.hist.png"),width=600,height=400,units="px")
		tpm=data[,-c(1,2)]
		log2tpm = log2(tpm[tpm>0.01])
		hist(log2tpm,main=paste0(isotype,"(",nrow(data),") type isoform log2 tpm"),breaks=40)
		dev.off()
	}
	
	#filter
	if(isotype=="="){
	}else if(isotype %in% c("c","k","m","n","j","u")){
		tmp = data[,-c(1,2)]
		pass = rowSums(tmp>1)
		data = data[pass>(sample_num/3),]
	}else {
		data = data[0,]
	}
	type_num[isotype,2] = nrow(data)
	
	#plot
	if(nrow(data)>10){
		png(paste0("iso_",isotype,"_log2.hist.filtered.png"),width=600,height=400,units="px")
		tpm=data[,-c(1,2)]
		log2tpm = log2(tpm[tpm>0.01])
		hist(log2tpm,main=paste0(isotype,"(",nrow(data),") type isoform log2tpm"),breaks=40)
		dev.off()
	}
	filter_isotpm = rbind(filter_isotpm,data)
}

write.table(type_num, file="isoform_type_count.txt", quote=F, sep="\t", row.names=T)
type_num$filtered = type_num$before-type_num$after
#type_num = type_num[-1,c("after","filtered")]
type_num = type_num[,c("after","filtered")]
type_num = t(type_num)
png(paste0("isoform.type.count.bar.png"),width=500,height=500,units="px")
barplot(height=type_num,main="isoform types count")
dev.off()
write.table(filter_isotpm, file="all_sample_transcript_filtered.txt", quote=F, sep="\t", row.names=F)