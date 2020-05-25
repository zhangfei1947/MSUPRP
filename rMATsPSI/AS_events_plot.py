import numpy as np
from collections import defaultdict
import os

types = ['SE','RI','MXE','A5SS','A3SS']


## AS event -- geneID
dic_AS_gene = {}
for AS in types:
    AS_loc_file = '%s.geneID.loc.txt' % (AS)
    with open(AS_loc_file) as f:
        for line in f:
            tmp = line.split('\t')
            dic_AS_gene[tmp[0]] = tmp[1]

## gene -- AS events (with high heritability)    
dic_gene_AS = defaultdict(list)
for AS in types:
    AS_rrBLUP_file = 'rrBLUP.%s_PSI.xls' % (AS)
    tmp = np.loadtxt(AS_rrBLUP_file, skiprows=1, dtype='str')
    h2 = tmp[...,1]
    h2 = h2.astype(np.float32)
    h = np.sqrt(h2)
    tmp = np.c_[tmp,h.T]
    for line in tmp:
        if line[4] > 0.4:
            gene = dic_AS_gene[line[0]]
            dic_gene_AS[gene].append(line[0])

## AS event -- samples PSIs
dic_AS_PSI_arr = {}
dic_AS_ID = {}
for AS in types:
    AS_PSI_file = '%s_PSI.filter.txt' % (AS)
    dic_AS_PSI_arr[AS] = np.loadtxt(AS_PSI_file, skiprows=1, dtype='str')
    dic_AS_ID[AS] = list(dic_AS_PSI_arr[AS][...,0])
with open(AS_PSI_file) as f:
    head = f.readline()
head = head.strip().split('\t')
sample_arr = np.asarray(head, dtype=str)

##
txt = 'gene\tAS_event\tsample\n'
txt_list = []
for gene,AS_events in dic_gene_AS.items():
    if len(AS_events) >= 3:
        txt_list.append([[gene],[],[]])
        for AS_ID in AS_events:
            AS = AS_ID.split('_')[0]
            index_in_arr = dic_AS_ID[AS].index(AS_ID)
            PSI_arr = dic_AS_PSI_arr[AS][index_in_arr][1:]
            PSI_arr_noNA = PSI_arr[np.where(PSI_arr!='NA')]
            PSI_arr_noNA = PSI_arr_noNA.astype(np.float32)
            sample_arr_noNA = sample_arr[np.where(PSI_arr!='NA')]
            PSI_arr_noNA = PSI_arr_noNA.astype(np.float32)
#            sort_index = list(np.argsort(PSI_arr_noNA))
#            length = len(sort_index)
#            print(PSI_arr_noNA)
#            print(list(np.argsort(PSI_arr_noNA)))
#            print([PSI_arr_noNA[sort_index.index(i)] for i in range(5)])
#            print([PSI_arr_noNA[sort_index.index(i)] for i in range(length-5,length)])
#            sp = [sample_arr_noNA[sort_index.index(i)] for i in range(5)] + [sample_arr_noNA[sort_index.index(i)] for i in range(length-5,length)]
            PSI_arr_noNA = list(PSI_arr_noNA)
            
            sp = [sample_arr_noNA[PSI_arr_noNA.index(min(PSI_arr_noNA))], sample_arr_noNA[PSI_arr_noNA.index(max(PSI_arr_noNA))]]
            sp = ','.join(sp)
            txt_list[-1][1].append(AS_ID)
            txt_list[-1][2].append(sp)
txt = '\n'.join(['\t'.join([';'.join(each2) for each2 in each]) for each in txt_list])
open('gene_ASevents_PSIsamples.txt','w').write(txt)        

for line in txt_list[:300]:
    gene = line[0][0]
    for i in range(len(line[1])):
        AS_ID = line[1][i]
        samples = line[2][i].split(',')
        AS,ID = AS_ID.split('_')
        rMATs_file = 'fromGTF.%s.txt' % (AS)
        AS_ID_rMATs_file = '%s.fromGTF.%s.txt' % (AS_ID,AS)
        os.system("head -n1 %s > %s" % (rMATs_file,AS_ID_rMATs_file))
        os.system("grep '^%s\t' %s >> %s" % (ID,rMATs_file,AS_ID_rMATs_file))
        bamdir = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/13.rMATs_144sample'
        basedir = '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/18.AS_plot'
        bams = [bamdir+'/'+each.replace('X','')+'.sorted.bam' for each in samples]
        b1 = ','.join(bams[:1])
        b2 = ','.join(bams[1:])
        t = AS
        e = AS_ID_rMATs_file
        o = basedir
        print("rmats2sashimiplot --b1 %s --b2 %s -t %s -e %s --l1 lowPSI --l2 highPSI --exon_s 1 --intron_s 5 -o %s" % (b1,b2,t,e,o)) 






