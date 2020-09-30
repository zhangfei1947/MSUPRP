infile = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/144sample_gffcompare/stringtie_144_sample.loci'
iso = 'isoform_TPM_ratio.filter28'

outfile = 'iso.loc'

dic_loc = {}
with open(infile) as f:
    for line in f:
        tmp = line[:80].replace('[',']').split('\t')
        tmp1 = tmp[1].split(']')
        ch = 'chr'+tmp[1][0]
        strand = tmp1[1]
        s,e = tmp1[2].split('-')
        if strand == '+':
            dic_loc[tmp[0]] = ch+'\t'+s+'\t'+e
        elif strand == '-':
            dic_loc[tmp[0]] = ch+'\t'+e+'\t'+s

txt = ''
with open(iso) as f:
    f.readline()
    for line in f:
        tmp = line[:40].split('\t')
        txt += tmp[0] + '\t' + dic_loc['X'+tmp[0].split('_X')[1]] + '\n'

open(outfile,'w').write(txt)
        
