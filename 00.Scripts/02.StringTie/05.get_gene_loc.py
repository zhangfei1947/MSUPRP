## get gene loc (gene|strand|chr|start|end) from stringtie merged gtf file

import sys,re
from collections import defaultdict

gtffile = sys.argv[1]
outdir = sys.argv[2]

data_list = defaultdict(lambda: [0,0,[]]) #chr|strand|start/end
with open(gtffile) as f:
    f.readline()
    f.readline() # two lines of annotation
    for line in f:
        tmp = line.split("\t")
        if tmp[2] == "transcript":
            geneid = re.search('gene_id "(.+?)";',tmp[8]).group(1)
            data_list[geneid][0] = tmp[0]
            data_list[geneid][1] = tmp[6]
            data_list[geneid][2] += tmp[3:5]

txt = "geneID\tchr\tstrand\tstart\tend\texpand\n"
for geneid,value in data_list.items():
    chro,strand,pos = value
    pos = map(int,pos)
    min_pos = min(pos)
    max_pos = max(pos)
    expand = max_pos - min_pos + 1
    if strand == "+":
        txt += "%s\t%s\t%s\t%s\t%s\t%s\n" % (geneid, chro, strand, min_pos, max_pos, expand)
    elif strand == "-":
        txt += "%s\t%s\t%s\t%s\t%s\t%s\n" % (geneid, chro, strand, max_pos, min_pos, expand)

open(outdir+"/gene_loc.txt","w").write(txt)