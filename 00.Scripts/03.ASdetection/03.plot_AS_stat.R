library(ggplot2)
args = commandArgs(T)
statpath = args[1]
setwd(statpath)

data <- read.table('AS.stat.plot.txt',header=T)
data$type <- factor(data$type, levels=c("Novel", "Annotated"))
#p <- ggplot(data, aes(x=AS,y=count,fill=type)) + geom_bar(stat='identity', position = position_stack(reverse=TRUE))
#p <- ggplot(data, aes(x=AS,y=count,fill=type)) + geom_bar(stat='identity')
p <- ggplot(data, aes(x=AS,y=count,fill=type)) + 
    geom_bar(stat='identity', width=0.9, position = position_stack()) + scale_fill_manual(values=c("#00BFC4", "#F8766D")) + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + 
    theme(legend.title=element_blank()) + theme(legend.position=c(0.25,0.75)) + 
    xlab("Alternative Splicing Event") + theme(axis.title.x = element_text(size=12, face="bold", vjust=0.1)) + 
    ylab("Count") + theme(axis.title.y = element_text(size=12, face="bold")) +
    scale_y_continuous(breaks=c(0,20000,40000,60000,80000,100000),labels = c("0","20k","40k","60k","80k","100k"))


ggsave("AS_stat.pdf", width = 8, height = 6, units = "cm")
ggsave("AS_stat.png", width = 8, height = 6, units = "cm")