## get gene loc (gene|strand|chr|start|end|TSS|TES|exon1_s,exon1_e;...) from stringtie merged gtf file


gtf_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/02.StringTie/02.stringtie_merge/stringtie_merge.gtf"
outpath = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr"


import sys,re
from collections import defaultdict

data_list = defaultdict(lambda: [0,0,[],""]) #chr | strand | start/end | exon1_s,exon1_e;...
with open(gtf_file) as f:
    f.readline()
    f.readline() # two lines of annotation
    for line in f:
        tmp = line.split("\t")
        if tmp[2] == "transcript":
            geneid = re.search('gene_id "(.+?)";',tmp[8]).group(1)
            data_list[geneid][0] = tmp[0]
            data_list[geneid][1] = tmp[6]
            data_list[geneid][2] += tmp[3:5]
        if tmp[2] == "exon":
            geneid = re.search('gene_id "(.+?)";',tmp[8]).group(1)
            data_list[geneid][3] += tmp[3]+","+tmp[4]+";"

txt = "geneID\tchr\tstrand\tstart\tend\tTSS\tTES\texon\n"
for geneid,value in data_list.items():
    chro,strand,pos,exon = value
    pos = map(int,pos)
    min_pos = min(pos)
    max_pos = max(pos)
#    expand = max_pos - min_pos + 1
    if strand == "+":
        txt += "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (geneid, chro, strand, min_pos, max_pos, min_pos, max_pos, exon)
    elif strand == "-":
        txt += "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % (geneid, chro, strand, min_pos, max_pos, max_pos, min_pos, exon)
        
open(outpath+"/gene.detailed.location.txt","w").write(txt)