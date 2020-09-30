import glob

infiles = glob.glob('/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/expressionQTL/*.eqtl.xls.FDR_1e-4')
gene_loc_file = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/expressionQTL/gene.loc'
Chr_len_file = '/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Chr.length'
snp_loc_file = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL/snploc.txt'

Chr_len = [0]*18
with open(Chr_len_file) as f:
    for line in f:
        tmp = line.strip().split()
        try:
            int(tmp[1])
            Chr_len[int(tmp[1])-1] = int(tmp[0])
        except:
            pass
print Chr_len

Chr_cum_len = [0]*18
for i in range(18):
    for j in range(i):
        Chr_cum_len[i] += Chr_len[j]
print Chr_cum_len

dic_snp = {}
with open(snp_loc_file) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        Chr = tmp[1][3:]
        try:
            int(Chr)
            pos = int(tmp[2])
            pos += Chr_cum_len[int(Chr)-1]
            dic_snp[tmp[0]] = pos
        except:
            pass

dic_gene = {}
with open(gene_loc_file) as f:
    for line in f:
        tmp = line.strip().split()
        gene = tmp[0]
        Chr = tmp[1][3:]
        pos = int(int(tmp[2])+int(tmp[3]))/2
        try:
            int(Chr)
            pos += Chr_cum_len[int(Chr)-1]
            dic_gene[gene] = pos
        except:
            pass

txt = 'SNP\tSNP_Pos\tGene\tGene_Pos\tsQTLtype\n'
for infile in infiles:
    print infile
    tmp = infile.split('/')[-1].split('.')
    sQTLtype = tmp[1]
    with open(infile) as f:
        f.readline()
        for line in f:
            tmp = line.split()
            snp = tmp[1]
            gene = tmp[2]
            try:
                gene_pos = dic_gene[gene]
                snp_pos = dic_snp[snp]
                txt += '%s\t%s\t%s\t%s\t%s\n' % (snp,snp_pos,gene,gene_pos,sQTLtype)
            except:
                pass

open('Pos_plot.txt','w').write(txt)


