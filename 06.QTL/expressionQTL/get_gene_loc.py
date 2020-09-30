import re

infile = '/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Sus_scrofa.Sscrofa11.1.97.gff3'
outfile = 'gene.loc'

txt = ''
with open(infile) as f:
    for line in f:
        if line[0] != '#':
            tmp = line[:100].split('\t')
            if tmp[2] == 'gene':
                ch = 'chr'+tmp[0]
                strand = tmp[6]
                s = tmp[3]
                e = tmp[4]
                m = re.search('ID=gene:(.+?);', tmp[8])
                g = m.group(1)
                if strand == '+':
                    txt += g + '\t' + ch + '\t' + s + '\t' + e + '\n'
                elif strand == '-':
                    txt += g + '\t' + ch + '\t' + e + '\t' + s + '\n'
open(outfile,'w').write(txt)
