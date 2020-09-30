library(bestNormalize)

gene <- read.table("known_gene_TPM.filter28",head=T,row.names=1)
nqt_row <- function(row){
    obj <- orderNorm(row)
    predict(obj)
}

output <- apply(gene, 1, nqt_row)
output <- t(output)
write.table(output, file="known_gene_TPM.nqt", quote=F, sep="\t")

print("gene done")

#
#gene <- read.table("isoform_TPM_ratio.filter28",head=T,row.names=1)
#nqt_row <- function(row){
#    obj <- orderNorm(row)
#    predict(obj)
#}
#output <- apply(gene, 1, nqt_row)
#output <- t(output)
#write.table(output, file="isoform_TPM_ratio.nqt", quote=F, sep="\t")
#
