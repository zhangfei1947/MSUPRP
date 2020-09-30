import sys

infile = sys.argv[1] #rrBLUP.SE_PSI.qValue.xls.h2_0.25_fdr_0.05 ...
output = sys.argv[2] #SE ...
ASID_Gene_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.Heritability/compare_plot/gene_expr_splice.herit.ASID.xls"

as2gene = {}
with open(ASID_Gene_file) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        as2gene[tmp[-1]] = tmp[0]

txt = []
with open(infile) as f:
    for line in f:
        asID = line.split()[0]
        txt.append(as2gene[asID])

txt = list(set(txt))
txt = '\n'.join(txt)+'\n'
open(output,'w').write(txt)
