library(ggplot2)
dat <- read.table("AS_stat.txt",head=T)
text = "Fig. 1 AS events detection. The x-axis represents the type of AS events. The y-axis represents the count of each AS type"
p <- ggplot(dat, aes(AS_type), colour="DoderBlue") + geom_histogram(stat="count")
ggsave("pointplot.png", plot=p, width=10, height=10)

