infile = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.Heritability/compare_plot/gene_expr_splice.herit.xls'

txt = 'heritability\ttype\n'
gene = ''
with open(infile) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        if tmp[0] != gene:
            txt += tmp[1]+'\t'+'gene_expression\n'
        if tmp[2] != '0':
            txt += tmp[2]+'\t'+tmp[3]+'\n'
        gene = tmp[0]

open('heritability_violin.txt','w').write(txt)
