`sed 1d Pos_plot.txt|cut -f 1|sort|uniq -c|sort -k 1 -n -r > Number_of_SNP_to_Gene.list`
`sed 1d Pos_plot.txt|cut -f 3|sort|uniq -c|sort -k 1 -n -r > Number_of_Gene_to_SNP.list`
