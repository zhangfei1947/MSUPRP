import math
ge = 'rrBLUP.output.gene_expression.qValue.sort.xls'
iso = 'rrBLUP.output.isoform_ratio.qValue.sort.xls'
#ge = 'rrBLUP.output.gene_expression.qValue_0.5.xls'
#iso = 'rrBLUP.output.isoform_ratio.qValue_0.5.xls'

iso_track = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/144sample_gffcompare/stringtie_144_sample.tracking'

dic = {}
with open(ge) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        gene = tmp[0]
        h2 = tmp[1]
        dic[gene] = [h2]

dic_is2gene = {}
with open(iso_track) as f:
    for line in f:
        tmp = line.split()
        iso_loc = tmp[0]+'_'+tmp[1]
        gene = tmp[2].split('|')[0]
        matchtype = tmp[3]
        dic_is2gene[iso_loc] = [gene,matchtype]



with open(iso) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        iso_loc = tmp[0]
        h2 = tmp[1]
        gene,matchtype = dic_is2gene[iso_loc]
        if matchtype in ['=','j','c','k','m','n']:
            if gene in dic:
                print 'good match',iso_loc,h2,gene,dic[gene][0],matchtype
                dic[gene].append([iso_loc, matchtype, h2])
            else:
                print 'good match no gene h2',iso_loc,h2,gene,'0',matchtype
                dic[gene] = ['0',[iso_loc, matchtype, h2]]
        else:
            print 'bad matchtype',iso_loc,h2,gene,matchtype


txt = 'gene\tgene_expression_h2\tiso_Loc\tmatchtype\tiso_ratio_h2\n'
for k,v in dic.items():
    if len(v) == 1:
        txt += '%s\t%s\t%s\n' % (k,v[0],'-\t-\t0')
    else:
        for each in v[1:]:
            each = '\t'.join(each)
            txt += '%s\t%s\t%s\n' % (k,v[0],each)
open('plot.txt','w').write(txt)
