import glob

infiles = glob.glob('/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL/*.eqtl.xls.FDR_1e-4')
AS_files = glob.glob('/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.AlternativeSplicing/merge_gtf/fromGTF.*.txt')
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

dic_AS = {}
for ASfile in AS_files:
    if 'novel' not in ASfile:
        print(ASfile)
        AStype = ASfile.split('/')[-1].split('.')[1]
        with open(ASfile) as f:
            f.readline()
            for line in f:
                tmp = line.strip().split()
                AS = AStype+'_'+tmp[0]
                Chr = tmp[3][3:]
                try:
                    Chr = int(Chr)
#                    print Chr
                    tmp = map(int,tmp[5:])
                    pos = int(min(tmp)/2 + max(tmp)/2 + Chr_cum_len[Chr-1])
                    dic_AS[AS] = int(pos)
                except:
                    pass

txt = 'SNP\tSNP_Pos\tAS\tAS_Pos\tAS_type\tsQTLtype\n'
for infile in infiles:
    tmp = infile.split('/')[-1].split('.')
    AStype = tmp[0]
    sQTLtype = tmp[1]
    with open(infile) as f:
        f.readline()
        for line in f:
            tmp = line.split()
            snp = tmp[1]
            AS = tmp[2]
            try:
                AS_pos = dic_AS[AS]
                snp_pos = dic_snp[snp]
                txt += '%s\t%s\t%s\t%s\t%s\t%s\n' % (snp,snp_pos,AS,AS_pos,AStype,sQTLtype)
            except:
                pass

open('Pos_plot.txt','w').write(txt)


