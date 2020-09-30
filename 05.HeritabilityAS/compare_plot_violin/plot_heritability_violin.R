library(ggplot2)
data <- read.table('heritability_violin.txt', header=T)
data$type <- factor(data$type, levels=c("gene_expression", "A5SS", "A3SS", "MXE", "RI", "SE"))
p <- ggplot(data, aes(x=type,y=heritability, fill=type)) +
    geom_boxplot(width=0.2,alpha=0.7) +
    geom_violin(width=1,alpha=0.3) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position="none") + 
    xlab("Type") + theme(axis.title.x = element_text(size=13, face="bold", vjust=0.1)) + 
    ylab("Heritability") + theme(axis.title.y = element_text(size=13, face="bold")) + 
    theme(axis.text.x = element_text(size=12))


ggsave("heritability_violin.pdf", width = 16, height = 9, units = "cm")
ggsave("heritability_violin.png", width = 16, height = 9, units = "cm")
