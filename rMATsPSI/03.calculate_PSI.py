import numpy as np
import sys

infile = sys.argv[1] # JCEC.raw.input.***.txt
sample1 = sys.argv[2] # 'ALL_1.txt'
sample2 = sys.argv[3] # 'ALL_2.txt'
spliceType = infile.split('.')[-2]

inclusion_list = []
exclusion_list = []
event_list = []

with open(infile) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split()
        inclusion = tmp[1]+','+tmp[3]
        inclusion = inclusion.split(',')
        inclusion_list.append(inclusion)
        exclusion = tmp[2]+','+tmp[4]
        exclusion = exclusion.split(',')
        exclusion_list.append(exclusion)
        event_list.append(tmp[0])
        I_length = float(tmp[5])
        E_length = float(tmp[6])


inclusion_arr = np.asarray(inclusion_list,dtype=float)
exclusion_arr = np.asarray(exclusion_list,dtype=float)
total_arr = inclusion_arr + exclusion_arr

inclusion_arr = inclusion_arr*100/I_length
exclusion_arr = exclusion_arr*100/E_length
print inclusion_arr
print exclusion_arr
total_arr_calc = inclusion_arr + exclusion_arr
total_arr_calc[total_arr < 4] = 0

PSI_arr = (inclusion_arr*100)/total_arr_calc
PSI_arr = np.around(PSI_arr, decimals=1, out=None)
headline = ['id'] + open(sample1,'r').read().replace('.bam','').strip().split(',') + open(sample2,'r').read().replace('.bam','').strip().split(',')
txt = '\t'.join(headline)+'\n'
i = 0
for line in PSI_arr:
    txt += spliceType+'_'+event_list[i]+'\t'+'\t'.join(map(str,line))+'\n'
    i += 1
txt = txt.replace('inf','nan')
open(spliceType+'.PSI.txt','w').write(txt)

