library(ggplot2)

infile <- "genepos.snppos.type.txt"

data = read.table(infile,header=T)
data = data[order(data$QTLtype,decreasing=TRUE),]

p <- ggplot(data, aes(gene_pos, pos)) +  geom_point(aes(colour = QTLtype), size=0.5) +
     theme(axis.text=element_text(size=12), axis.text.y=element_text(angle=45), title=element_text(size=14), panel.background=element_blank(), panel.border=element_rect(fill=NA)) + 
     theme(legend.title=element_blank()) + theme(legend.position=c(0.1,0.9)) + theme(legend.text=element_text(size=13)) +
     ylab("gene position") +
     xlab("eQTL position")

ggsave("eQTL.location.pdf", width=40, height=35, units="cm")
ggsave("eQTL.location.png", width=20, height=18, units="cm")