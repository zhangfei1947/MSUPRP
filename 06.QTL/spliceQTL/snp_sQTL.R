library(ggplot2)
data = read.table('Pos_plot.txt',header=T)
p <- ggplot(data, aes(SNP_Pos, AS_Pos)) +  geom_point(aes(colour = sQTLtype), size=1) +
     theme(axis.text=element_text(size=12), axis.text.y=element_text(angle=45), title=element_text(size=14), panel.background=element_blank(), panel.border=element_rect(fill=NA)) + 
     theme(legend.title=element_blank()) + theme(legend.position=c(0.1,0.9)) + theme(legend.text=element_text(size=13)) +
     ylab("AS event position") +
     xlab("SNP position")

ggsave("sQTL.pdf", width=40, height=35, units="cm")
ggsave("sQTL.png", width=20, height=18, units="cm")
