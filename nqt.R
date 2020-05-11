library(bestNormalize)
args <- commandArgs(trailingOnly=TRUE)
PSI_file <- args[1]
type <- unlist(strsplit(PSI_file, "[.]"))[[1]]

gene <- read.table(PSI_file,head=T,row.names=1)
nqt_row <- function(row){
    obj <- orderNorm(row)
    predict(obj)
}

output <- apply(gene, 1, nqt_row)
output <- t(output)
write.table(output, file=paste0(type,".nqt"), quote=F, sep="\t")

