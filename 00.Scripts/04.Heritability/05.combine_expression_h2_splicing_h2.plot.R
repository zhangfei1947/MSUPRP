library(ggplot2)
library(ggpubr)

args = commandArgs(T)
wkpath = args[1]
exp_as_h = args[2]

setwd(wkpath)

dat <- read.table(exp_as_h,head=T)
dat2 <- data.frame(x = c(0,1), y = c(0,1))
p1 <- ggplot() + geom_point(dat, mapping=aes(splicing_h, expression_h, shape=factor(splicing_type), colour=factor(splicing_type)), size=0.5, alpha=0.25) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +    
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) + guides(shape = guide_legend(override.aes = list(size = 2), nrow=1)) + 
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
    
#ggsave(file="gene_expr_splicing_h.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="A3SS"),]
p2 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#F8766D', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.A3SS.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="A5SS"),]
p3 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#B79F00', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.A5SS.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="MXE"),]
p4 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#00BA38', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.MXE.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="NO"),]
p5 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#00BFC4', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + 
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.NO.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="RI"),]
p6 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#619CFF', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) + 
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) + theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.RI.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="SE"),]
p7 <- ggplot() + geom_point(dat3, mapping=aes(x=splicing_h, y=expression_h, fill=splicing_type), shape=16, colour='#F564E3', size=1, alpha=0.2) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.2) +
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank(), axis.line = element_line(colour = "black")) +
    theme(legend.position=c(0.2,0.97)) + theme(legend.background=element_blank()) + theme(legend.title=element_blank()) +  theme(legend.key.size = unit(0.7, 'lines')) + guides(colour = guide_legend(override.aes = list(alpha = 1))) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(plot.margin = unit(c(0,0,1,0), "lines")) +
    theme(axis.title=element_blank())
#ggsave(file="gene_expr_splicing_h.SE.png", plot=p,width = 25, height = 20, units = "cm")






p <- ggarrange(p3,p2,p4,p6,p7,p5,ncol=2,nrow=3)
p <- annotate_figure(p, left = text_grob("Gene expression heritability", face = "bold", size = 13, rot = 90), bottom = text_grob("Alternative splicing events heritability", face = "bold", size = 13) )
ggsave("heritability.pdf", width=15, units="cm")
ggsave("heritability.png", width=15, units="cm")

