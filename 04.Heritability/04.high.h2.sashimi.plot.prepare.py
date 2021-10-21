import sys,os
import numpy as np

asrrblup = sys.argv[1]
psidir = sys.argv[2]
rmatsdir = sys.argv[3]
sashimidir = sys.argv[4]
bamdir = sys.argv[5]

#A3SS A5SS MXE RI SE
AS_idx = {"A3SS":0, "A5SS":1, "MXE":2, "RI":3, "SE":4 }
#load PSI as arrays
PSI_array = [0,0,0,0,0]
PSI_sp = [0,0,0,0,0]
PSI_event = [0,0,0,0,0]
for AS in ["A3SS", "A5SS", "MXE", "RI", "SE"]:
    tmp = np.loadtxt(psidir+"/"+AS+".PSI.txt", delimiter="\t", dtype="str")
    PSI_sp[AS_idx[AS]] = tmp[0,:].tolist()[1:]
    PSI_event[AS_idx[AS]] = tmp[:,0][1:]
    PSI_array[AS_idx[AS]] = tmp[1:,1:].astype('float')

#load AS events as list
AS_mats = [0,0,0,0,0]
for AS in ["A3SS", "A5SS", "MXE", "RI", "SE"]:
    AS_mats[AS_idx[AS]] = open(rmatsdir+"/"+AS+".MATS.JC.txt","r").readlines() #contain first line of header #rMATS count from 0!

#from AS rrBLUP file to prepare files
os.chdir(sashimidir)
#sashimi plot shell
plotshell = ""
with open(asrrblup) as f:
    f.readline()
    for line in f:
        tmp = line.strip().split("\t")
        if float(tmp[4]) < 0.01: #fdr qval < 0.01
            as_id = tmp[0]
            type = tmp[0].split("_")[0]
            idx = int(tmp[0].split("_")[1])
            #get high PSI samples and low PSI samples
            PSI_idx = np.where(PSI_event[AS_idx[type]] == as_id)[0]
            arr = PSI_array[AS_idx[type]][PSI_idx,][0]
            arr = arr[np.isfinite(arr)]
            sorted_index_array = np.argsort(arr)
            n = 8
            high_psi_index = sorted_index_array[-n:] 
            low_psi_index = sorted_index_array[:n]
#            print high_psi_index
#            print np.take(arr, high_psi_index)
#            print low_psi_index
#            print np.take(arr, low_psi_index)
            high_psi_index = np.random.choice(high_psi_index, 4, replace=False)
            low_psi_index = np.random.choice(low_psi_index, 4, replace=False)
            high_sample = np.take(PSI_sp[AS_idx[type]], high_psi_index)
            low_sample = np.take(PSI_sp[AS_idx[type]], low_psi_index)
#            print high_sample
#            print low_sample
            high_bam = []
            for sp in high_sample:
                high_bam.append(bamdir+"/"+sp+".sort.bam")
            high_bam = ",".join(high_bam)
            low_bam = []
            for sp in low_sample:
                low_bam.append(bamdir+"/"+sp+".sort.bam")
            low_bam = ",".join(low_bam)
            #get mats file
            mats_line =  type+"_"+AS_mats[AS_idx[type]][idx+1] # rMAts count from 0 eg: SE_0 in line 2(index 1=0+1)
            ##delete chr in the MATS file which is added by rMATs software, cannot recognized by next plot
            mats_line = mats_line.replace("chr","")
            mats_file = as_id+".mats.JC.txt"
            open(mats_file,"w").write(mats_line)
            #write plot cmd
            plotshell += "rmats2sashimiplot --b1 {high_bam} --b2 {low_bam} -t {type} -e {mats_file} --l1 {high_sample} --l2 {low_sample} -o ./\n\n".format(high_bam=high_bam, low_bam=low_bam, type=type, mats_file=mats_file, high_sample=",".join(high_sample), low_sample=",".join(low_sample))
open("high_h2_AS_sashimi_plot.sh","w").write(plotshell)
