#$total_AS_dir  $anno_AS_dir  $gene_list_file  $AS_stat_dir  $PSI_dir
#

import sys
import numpy as np

total_AS_dir = sys.argv[1]
anno_AS_dir = sys.argv[2]
gene_list_file = sys.argv[3]
AS_stat_dir = sys.argv[4]
PSI_dir = sys.argv[5]

gene_list = set(open(gene_list_file,"r").read().strip().split("\n"))
AS_stat = [["type","SE","RI","MXE","A5SS","A3SS"],["Total"],["Annotated"],["Novel"],["matched"]]
AS_types = ["SE","RI","MXE","A5SS","A3SS"]
for AStype in AS_types:
    print AStype
    total_file = total_AS_dir+"/"+AStype+".MATS.JCEC.txt"
    bam_list_file = total_AS_dir+"/bam_list.txt"
    anno_file = anno_AS_dir+"/"+AStype+".MATS.JCEC.txt"
    out_PSI = PSI_dir+"/"+AStype+".PSI.txt" 
    
    sps = open(bam_list_file,"r").read().strip().split(",")
    sps = [each.split("/")[-1].split(".")[0] for each in sps]
    
    #for match AS events
    total_event_exons = set()  # exonStart_exonEnd_upstreamEs_upstreamEE_downstreamES_downstreamEE; riStart_riEnd.....
    anno_event_exons = set()
    #for calculate PSI
    id = []
    inclusion = []
    exclusion = []
    I_length = []
    E_length = []
    
    with open(total_file) as f:
        headline = f.readline()
        headline = headline.split("\t")
        for line in f:
            tmp = line.split("\t")
            if tmp[1].strip('"') not in gene_list:
                continue
            # tmp[1] geneid in gene_list, then:
            #for calculate PSI
            id.append(AStype+"_"+tmp[0])
            inclusion.append(tmp[headline.index("IJC_SAMPLE_1")].split(","))
            exclusion.append(tmp[headline.index("SJC_SAMPLE_1")].split(","))
            I_length.append(tmp[headline.index("IncFormLen")])
            E_length.append(tmp[headline.index("SkipFormLen")])
            #for match AS events
            if AStype == "MXE": #8 position: 1stExonStart_0base      1stExonEnd      2ndExonStart_0base      2ndExonEnd      upstreamES      upstreamEE      downstreamES    downstreamEE
                total_event_exons.add("_".join(tmp[5:13]))
            else: #6 position: longExonStart_0base     longExonEnd     shortES shortEE flankingES      flankingEE
                total_event_exons.add("_".join(tmp[5:11]))
                
    with open(anno_file) as f:
        headline = f.readline()
        for line in f:
            tmp = line.split("\t")
            if tmp[1].strip('"') not in gene_list:
                continue
            #for match AS events
            if AStype == "MXE": #8 position: 1stExonStart_0base      1stExonEnd      2ndExonStart_0base      2ndExonEnd      upstreamES      upstreamEE      downstreamES    downstreamEE
                anno_event_exons.add("_".join(tmp[5:13]))
            else: #6 position: longExonStart_0base     longExonEnd     shortES shortEE flankingES      flankingEE
                anno_event_exons.add("_".join(tmp[5:11]))
                
    #match AS events
    m = 0
    for each in anno_event_exons:
        if each in total_event_exons:
            m += 1

    #write count & match
    AS_stat[1].append(str(len(total_event_exons)))
    AS_stat[2].append(str(len(anno_event_exons)))
    AS_stat[3].append(str(len(total_event_exons)-len(anno_event_exons)))
    AS_stat[4].append(str(m))
    
    #calculate PSI
    inclusion_arr = np.asarray(inclusion,dtype=float)
    exclusion_arr = np.asarray(exclusion,dtype=float)
    total_arr = inclusion_arr + exclusion_arr
#    np.savetxt(AStype+'.totalreads.txt', total_arr, delimiter='\t')
    I_length = np.asarray(I_length,dtype=float).reshape(len(I_length),-1)
    E_length = np.asarray(E_length,dtype=float).reshape(len(E_length),-1)
    
    inclusion_arr = inclusion_arr*100/I_length
    exclusion_arr = exclusion_arr*100/E_length
    
    total_arr_calc = inclusion_arr + exclusion_arr
    # filter out total events without enough supported reads
    total_arr_calc[total_arr < 5] = 0

    PSI_arr = (inclusion_arr*100)/total_arr_calc
    PSI_arr = np.around(PSI_arr, decimals=1, out=None)
    
    #write out PSI
    id = np.asarray(id)
    id = id.reshape(len(id),-1)
    PSI = np.hstack((id,PSI_arr))
    PSI = PSI.astype(str)
    PSI = PSI.tolist()
    txt = "id" + "\t" + "\t".join(sps) + "\n"
    txt += "\n".join(["\t".join(each) for each in PSI]) + "\n"
    open(out_PSI,"w").write(txt)

#write out AS stat
txt = "\n".join(["\t".join(each) for each in AS_stat]) + "\n"
open(AS_stat_dir+"/AS.stat.txt","w").write(txt)
#write out AS stat for plot
txt = "AS\ttype\tcount\n"
for i in range(1,6):
    txt += AS_stat[0][i] + "\tAnnotated\t" + AS_stat[2][i] + "\n"
    txt += AS_stat[0][i] + "\tNovel\t" + AS_stat[3][i] + "\n"
open(AS_stat_dir+"/AS.stat.plot.txt","w").write(txt)