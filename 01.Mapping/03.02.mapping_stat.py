#Extract mapping stat form hisat2 summary files and count_junction stat
#Argument: summary_dir, stat_dir, count_junction_stat file
#output: sample total_reads unique_concordant_mapped overall_mapped junction_mapped junction/total_reads junction/overall_map 

import sys
import glob
from collections import defaultdict
import re

sum_dir = sys.argv[1]
stat_dir = sys.argv[2]
junct_stat = sys.argv[3]
outfile = stat_dir+"/mapping_stat.txt"

stat = defaultdict(lambda: [0,0,0,0]) #total_reads  unique_concordant_mapped  overall_mapped  junction_mapped

all_sums = glob.glob(sum_dir+"/*.summary.txt")   #1592_TCCGGAGA-CAGGACG_L006.summary.txt
for sumfile in all_sums:
    sp = sumfile.split("/")[-1].split("_")[0]
    txt = open(sumfile).read()
    m = re.search("(\d+?) reads; of these:", txt) #total pairs
    if m:
        stat[sp][0] += int(m.group(1))*2
    else:
        sys.exit(sumfile)
    m = re.search("(\d+?) .+? aligned concordantly exactly 1 time", txt) #pair_unique_concordant_mapped
    if m:
        stat[sp][1] += int(m.group(1))*2
        stat[sp][2] += int(m.group(1))*2
    else:
        sys.exit(sumfile)
    m1 = re.search("(\d+?) .+? aligned concordantly >1 times", txt) #pair_multiple_concordant_mapped
    m2 = re.search("(\d+?) .+? aligned discordantly 1 time", txt) #pair_discordant_mapped
    m3 = re.search("(\d+?) .+? aligned exactly 1 time", txt) #unpair_unique
    m4 = re.search("(\d+?) .+? aligned >1 times", txt) #unpair_multiple
    if m1 and m2 and m3 and m4:
        stat[sp][2] =  stat[sp][2] + int(m1.group(1))*2 + int(m2.group(1))*2 + int(m3.group(1)) + int(m4.group(1))

print "sample","overall_map_summary","overall_map_count","difference"
lines =  open(junct_stat,"r").readlines()
for line in lines[1:]:
    tmp = line.split(" ") #sample  mapped_reads  junction_mapped  junction_map_rate
    stat[tmp[0]][3] = int(tmp[2])
    print tmp[0],stat[tmp[0]][2],tmp[1],stat[tmp[0]][2]-int(tmp[1])

outtxt = "sample\ttotal_reads\tuniq_concordant_mapped\toverall_mapped\tjunction_mapped\tjunction/overallmapped\n"
for sp,tmp in stat.items():
    tmp = map(float,tmp)
    outtxt += "%s\t%d\t%d(%s%%)\t%d(%s%%)\t%d(%s%%)\t%s%%\n" % (sp, tmp[0], tmp[1], round(tmp[1]*100/tmp[0],2), tmp[2], round(tmp[2]*100/tmp[0],2), tmp[3], round(tmp[3]*100/tmp[0],2), round(tmp[3]*100/tmp[2],2))
open(outfile,"w").write(outtxt)
