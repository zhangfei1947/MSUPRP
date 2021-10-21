library(ggplot2)
library(stringr)


wkpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/04.Heritability"
setwd(wkpath)

as_herit_file = "rrBLUP.AS.txt"
gene_herit_file = "rrBLUP.genetpm.txt"

as_herit = read.table(as_herit_file,header=TRUE,as.is=TRUE)
as_herit$type = str_split_fixed(rownames(as_herit), "_", 2)[,1]

gene_herit = read.table(gene_herit_file,header=TRUE,as.is=TRUE)
gene_herit$type = "gene_expression"

data = rbind(as_herit[which(as_herit$h2>0.001),c("h2","type")], gene_herit[which(gene_herit$h2>0.001),c("h2","type")])

data$type <- factor(data$type, levels=c("gene_expression", "A5SS", "A3SS", "MXE", "RI", "SE"))
p <- ggplot(data, aes(x=type,y=h2, fill=type)) +
    geom_boxplot(width=0.2,alpha=0.7) +
#    geom_violin(width=1,alpha=0.3) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position="none") + 
    xlab("Type") + theme(axis.title.x = element_text(size=13, face="bold", vjust=0.1)) + 
    ylab("Heritability") + theme(axis.title.y = element_text(size=13, face="bold")) + 
    theme(axis.text.x = element_text(size=12))


ggsave("heritability_violin.pdf", width = 16, height = 9, units = "cm")
ggsave("heritability_violin.png", width = 16, height = 9, units = "cm")
