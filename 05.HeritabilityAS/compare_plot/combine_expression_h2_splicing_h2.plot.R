library(ggplot2)

dat <- read.table('gene_expr_splice.herit.xls',head=T)
dat2 <- data.frame(x = c(0,1), y = c(0,1))
p <- ggplot() + geom_point(dat, mapping=aes(splicing_h, expression_h, shape=factor(splicing_type), colour=factor(splicing_type)), size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="A3SS"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=16, colour='#F8766D', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.A3SS.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="A5SS"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=17, colour='#B79F00', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.A5SS.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="MXE"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=15, colour='#00BA38', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.MXE.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="NO"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=3, colour='#00BFC4', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.NO.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="RI"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=7, colour='#619CFF', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.RI.png", plot=p,width = 25, height = 20, units = "cm")

dat3 <- dat[which(dat$splicing_type=="SE"),]
p <- ggplot() + geom_point(dat3, mapping=aes(splicing_h, expression_h), shape=8, colour='#F564E3', size=1, alpha=0.5) + coord_fixed() + geom_line(dat2, mapping=aes(x, y),alpha=0.5)
ggsave(file="gene_expr_splicing_h.SE.png", plot=p,width = 25, height = 20, units = "cm")
