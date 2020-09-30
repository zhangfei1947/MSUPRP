import sys

mappingfile = sys.argv[1]
junctionfile = sys.argv[2]

dic = {}
txt = 'sample total_reads paired_unique_mapped_reads overall_mapped_rate junction_reads\n'
with open(mappingfile) as f:
    f.readline()
    for line in f:
        tmp = line.split(',')
        if tmp[0] not in dic:
            dic[tmp[0]] = [[],[],[]] #total reads, paired unique mapped reads, alignment reads
        dic[tmp[0]][0].append(int(tmp[1])*2)
        dic[tmp[0]][1].append(int(tmp[2])*2)
        dic[tmp[0]][2].append(float(tmp[3][:-1])*int(tmp[1])*2)

with open(junctionfile) as f:
    for line in f:
        tmp = line.strip().split()
        sp = tmp[0].split('.')[0]
        junc = int(tmp[1])
        total = sum(dic[sp][0])
        mapped = sum(dic[sp][1])
        alignment = sum(dic[sp][2])
        maprate = str(round(mapped*100.0/total,2))+'%'
        alignrate = str(round(alignment*1.0/total,2))+'%'
        juncrate = str(round(junc*100.0/total,2))+'%'
        txt += '%s %s %s %s %s\n' % (sp, str(total), str(mapped)+'('+maprate+')', alignrate, str(junc)+'('+juncrate+')')

open('mapping_stat.txt','w').write(txt)
