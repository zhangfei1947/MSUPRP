#$wkdir $rrblupexp $rrblupas $ASgene $exp_as_h

args = commandArgs(T)
wkpath = args[1]
rrblupexp = args[2]
rrblupas = args[3]
ASgene = args[4]
exp_as_h = args[5]

setwd(wkpath)
exp_data = read.table(rrblupexp,header=T,row.names=1)
exp_data = exp_data[exp_data$qValue<0.01,]
as_data = read.table(rrblupas,header=T,row.names=1)
as_data = as_data[as_data$qValue<0.01,]
AS_gene = read.table(ASgene)

#splicing events heritability
splicing_h = as.numeric(as_data[,c("h2")])
splicing_type = as.vector(unlist(lapply(strsplit(rownames(as_data),"_"), function(x) x[1])))
as_event = rownames(as_data)
data = data.frame(cbind(splicing_h,splicing_type))
data$as_event = as.vector(as_event)
data$gene = AS_gene$V2[match(data$as_event, AS_gene$V1)]
data$expression_h = exp_data$h2[match(data$gene, row.names(exp_data))]
data = data[,-which(colnames(data)==c("as_event"))]
dim(data)

#expression heritabilty without splicing 
expression_h = exp_data[,c("h2")]
gene = rownames(exp_data)
data2 = data.frame(cbind(expression_h,gene))
data2 = data2[is.na(match(gene,data$gene)),]
data2$splicing_type = rep("NO",nrow(data2))
data2$splicing_h = rep("0", nrow(data2))
dim(data2)
data = rbind(data,data2)
data$expression_h[is.na(data$expression_h)] = 0
write.table(data,file=exp_as_h,quote=F,sep="\t",row.names=F)