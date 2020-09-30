library(ggplot2)
data <- read.table('rMATs_stat.txt', header=T, )
data$type <- factor(data$type, levels=c("Novel", "Annotated"))
#p <- ggplot(data, aes(x=AS,y=count,fill=type)) + geom_bar(stat='identity', position = position_stack(reverse=TRUE))
#p <- ggplot(data, aes(x=AS,y=count,fill=type)) + geom_bar(stat='identity')
p <- ggplot(data, aes(x=AS,y=count,fill=type)) + 
    geom_bar(stat='identity', width=0.9, position = position_stack()) + scale_fill_manual(values=c("#00BFC4", "#F8766D")) + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + 
    theme(legend.title=element_blank()) + theme(legend.position=c(0.25,0.75)) + 
    xlab("Alternative Splicing Event") + theme(axis.title.x = element_text(size=12, face="bold", vjust=0.1)) + 
    ylab("Count") + theme(axis.title.y = element_text(size=12, face="bold")) +
    scale_y_continuous(breaks=c(0,10000,20000, 30000, 40000, 50000),labels = c("0","10k","20k","30k","40k","50k"))


ggsave("rMATs.pdf", width = 8, height = 6, units = "cm")
ggsave("rMATs.png", width = 8, height = 6, units = "cm")
