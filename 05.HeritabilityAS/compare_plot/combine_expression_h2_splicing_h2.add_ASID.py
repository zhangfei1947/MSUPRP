##
## Add geneID.correspond.txt
##
import math
from collections import defaultdict


events = ['SE','A5SS','A3SS','MXE','RI']
expr_file = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.Heritability/Gene_Heritability/rrBLUP.output.gene_expression.xls'
sp_gtf_file_format = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/03.AlternativeSplicing/merge_gtf/fromGTF.%s.txt'
sp_file_format = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.Heritability/AS_Heritability/rrBLUP.%s_PSI.xls'
geneID_link_file = 'geneID.correspond.txt'
output = 'gene_expr_splice.herit.ASID.xls'
output_txt = ''

geneID_link = defaultdict(str)
with open(geneID_link_file) as f:
    for line in f:
        tmp = line.strip().split()
        geneID_link[tmp[0]] = tmp[1]

output_txt = 'gene\texpression_h\tsplicing_h\tsplicing_type\n'
dic_event_gene = defaultdict(list)
dic_sp_h = {}

for event in events:
    print event
    sp_gtf_file = sp_gtf_file_format % (event)
    with open(sp_gtf_file) as f:
        f.readline()
        for line in f:
            sp,gene = line.split('\t')[:2]
            sp = event + '_' + sp
            gene = gene.strip('"')
            if gene.startswith('MS'):
                if gene in geneID_link:
                    gene = geneID_link[gene]
                    dic_event_gene[gene].append(sp)
            else:
                dic_event_gene[gene].append(sp)

    sp_file = sp_file_format % (event)
    with open(sp_file) as f:
        f.readline()
        for line in f:
            sp,h2 = line.split('\t')[:2]
            h = math.sqrt(float(h2))
            dic_sp_h[sp] = h
    

genes_have_h_no_sp = 0    
genes_have_h = []
with open(expr_file) as f:
    f.readline()
    for line in f:
        gene,h2 = line.split('\t')[:2]
        genes_have_h.append(gene)
        h = math.sqrt(float(h2))
        if dic_event_gene[gene]:
            for sp in dic_event_gene[gene]:
                if sp in dic_sp_h:
                    output_txt += '%s\t%s\t%s\t%s\n' % (gene,h,dic_sp_h[sp],sp)
        else:
            output_txt += '%s\t%s\t0\tNO\n' % (gene,h)
            genes_have_h_no_sp += 1

genes_have_sp = dic_event_gene.keys()
genes_have_sp_no_h = set(genes_have_sp) - set(genes_have_h)
print "genes_have_sp_no_h",len(genes_have_sp_no_h)
print "genes_have_h_no_sp",genes_have_h_no_sp
for gene in genes_have_sp_no_h:
#    print dic_event_gene[gene]
    for sp in dic_event_gene[gene]:
        if sp in dic_sp_h:
#            print dic_sp_h[sp]
            output_txt += '%s\t%s\t%s\t%s\n' % (gene,0,dic_sp_h[sp],sp.split('_')[0])  #actually there is no sp in this type

open(output,'w').write(output_txt)
