library(ggplot2)

wkpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.ModelSelection/02.sQTL"
setwd(wkpath)
infile <- "genepos.snppos.type.txt"

qtlpos = read.table(infile,header=T)
qtlpos = qtlpos[order(qtlpos$QTLtype,decreasing=TRUE),]

p <- ggplot() +  geom_point(data=qtlpos, aes(gene_pos, pos,colour = QTLtype), size=0.5) +
     theme(axis.text=element_blank(), axis.ticks=element_blank(), title=element_text(size=14), panel.background=element_blank(), panel.border = element_blank()) +  
     theme(legend.title=element_blank()) + theme(legend.text=element_text(size=12,face="italic")) +
     ylab("AS position") +
     xlab("sQTL position")

DOY = c(0,274330532,426266526,559115439,690026354,794552361,965395948,1087240047,1226206284,1365718367,1435077820,1514247798,1575850547,1784185137,1925940583,2066353308,2146297588,2209791669)
DOY2 = c(274330532,426266526,559115439,690026354,794552361,965395948,1087240047,1226206284,1365718367,1435077820,1514247798,1575850547,1784185137,1925940583,2066353308,2146297588,2209791669,2265774640)
stripe = c(1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0)

rects = as.data.frame(cbind(DOY,DOY2,stripe))
rects$stripe = as.factor(rects$stripe)

p <- p + geom_rect(data=rects,aes(xmin=DOY, xmax=DOY2, ymin=0, ymax=2265774640, fill=stripe), alpha=0.2) + 
     geom_rect(data=rects,aes(xmin=0, xmax=2265774640, ymin=DOY, ymax=DOY2, fill=stripe), alpha=0.2) + 
     scale_fill_manual(values=c("white", "grey50")) + guides(fill=FALSE)

x = c(0,274330532,426266526,559115439,690026354,794552361,965395948,1087240047,1226206284,1365718367,1435077820,1514247798,1575850547,1784185137,1925940583,2066353308,2146297588,2209791669)
y = c(0,274330532,426266526,559115439,690026354,794552361,965395948,1087240047,1226206284,1365718367,1435077820,1514247798,1575850547,1784185137,1925940583,2066353308,2146297588,2209791669)
chrs = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18")

p <- p + geom_text(aes(x=c(137165266,350298529,492690982,624570896,742289358,879974154,1026317998,1156723166,1295962326,1400398094, 1474662809,1545049172,1680017842, 1855062860, 1996146946, 2106325448, 2178044628, 2237783154), y=-60000000, label=chrs)) +
     geom_text(aes(y=c(137165266,350298529,492690982,624570896,742289358,879974154,1026317998,1156723166,1295962326,1400398094, 1474662809,1545049172,1680017842, 1855062860, 1996146946, 2106325448, 2178044628, 2237783154), x=-60000000, label=chrs))


ggsave("sQTL.location.pdf", width=40, height=35, units="cm")
ggsave("sQTL.location.png", width=20, height=18, units="cm")