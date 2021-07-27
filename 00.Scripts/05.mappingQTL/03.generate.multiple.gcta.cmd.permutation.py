#input gcta.pheno.txt splitted files
#input gcta wkdir

import sys

def chunkIt(seq, num):
    avg = len(seq) / float(num)
    out = []
    last = 0.0

    while last < len(seq):
        out.append(seq[int(last):int(last + avg)])
        last += avg

    return out
    
namefiles = sys.argv[1].strip(",").split(",")
wkdir = sys.argv[2]

#split accoring to input files

cmd = '''
while [[ `wc -l <{gene}.fastGWA` -lt 28456 ]]
do
    gcta64 --bfile msuprp --grm-sparse sp_msuprp --fastGWA-mlm --pheno {file} --mpheno {N} --covar fixed.txt --threads 1 --out {gene} \n
done
awk 'BEGIN{{ORS=",";print"\\n{gene}"}}$10<0.01{{print$10}}' {gene}.fastGWA >> gene.pvalue.txt
'''

cmd_txt = '''#!/bin/bash --login
cd %s
''' % (wkdir)

file_no = 0
gene_no = 0
for namefile in namefiles:
    file_no += 1
    phenofile = namefile.replace(".names", "");
    i = 1
    for eachname in open(namefile,"r").read().strip("\n").split("\n"): 
        gene_no += 1
        cmd_txt += cmd.format(gene=eachname, file=phenofile, N=i)
        i += 1
        if (i%500) == 0:
            cmd_txt += "\nrm *fastGWA *log\n"

cmd_txt += "\nrm *fastGWA *log\n"
open("multiple.gcta.sh","w").write(cmd_txt)
