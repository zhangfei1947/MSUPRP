
import sys,glob,re
from collections import defaultdict
#from multiprocessing import Pool
import numpy as np


##input: original dir(fastGWA files inside); permutation dirs common part(*.pvalue.txt files inside)

original_dir = sys.argv[1]
permut_dir = sys.argv[2]
permut_files = glob.glob(permut_dir+"*/*pvalue.txt") 

##store all permutation results in a dict
permut_dict = defaultdict(str) #{pheno:one string of all pvalue with ","}
for pfile in permut_files:
    print pfile
    with open(pfile) as f:
        f.readline()
        for line in f:
            m = re.search('[^,]+,',line)
            pheno = m.group()
            l = len(pheno)
            permut_dict[pheno[:-1]] += line.rstrip("\n")[l:]

##FDR calculation through multiprocessing
fastGWA_files = glob.glob(original_dir+"/*fastGWA")

def cal_fdr(fastGWA,permut_dict):
    print fastGWA
    pheno = fastGWA.split("/")[-1].replace(".fastGWA","")
    permuts = permut_dict[pheno].rstrip(",").split(",")
    permuts = map(float,permuts)
    permuts = sorted(permuts)
    d = np.loadtxt(fastGWA,delimiter="\t",dtype="str",skiprows=1)
    p = d[:,9].astype(float)
    d = d[p.argsort()]
    p = d[:,9].astype(float)
    idx = 0
    p_num = 0
    permutp = permuts[0]
    fdr_list = [1]*len(p)
#    print p[:40]
#    print permuts[:40]
    last_fdr = 0
    while 1:
        for eachp in p:
            p_num +=1
            while permutp < eachp:
                idx += 1
                try:
                    permutp = permuts[idx]
                except:
                    idx = 1000000
                    break
            fdr = (idx+1)/200.0/p_num
            if fdr < last_fdr:
                fdr = last_fdr
            if fdr >= 1:
                fdr = 1
                fdr_list[p_num-1] = fdr
                break
            last_fdr = fdr
#            print eachp,idx,fdr
            fdr_list[p_num-1] = fdr
        break
    fdr_list = np.array(fdr_list)
    d = np.hstack((d[:,[0,1,2,9]],fdr_list.reshape(-1,1)))
    np.savetxt(fastGWA+".fdr",d,fmt="%s",delimiter="\t")

for fastGWA in fastGWA_files:
    cal_fdr(fastGWA,permut_dict)

'''
p = Pool(6)
for fastGWA in fastGWA_files:
    p.apply_async(cal_fdr, args=(fastGWA,permut_dict,))
print('Waiting for all subprocesses done...')
p.close()
p.join()
print('All subprocesses done.')
'''