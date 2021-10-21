import sys
import glob
from collections import defaultdict
genetpmfilter = sys.argv[1]
rmatsdir = sys.argv[2]
asstat = sys.argv[3]
psifilteredfiles = sys.argv[4]
outdir = sys.argv[5]


f = open(genetpmfilter,"r")
f.readline()
gene_pass_tpm_filter = [each.split("\t")[0] for each in f.readlines()]
gene_pass_tpm_filter = set(gene_pass_tpm_filter)


as2gene = dict()
rmats_jcec_files = glob.glob(rmatsdir+"/*.MATS.JCEC.txt")
for file in rmats_jcec_files:
    type = file.split("/")[-1].split(".")[0]
    with open(file) as f:
        f.readline()
        for line in f:
            tmp = line.split("\t")
            as2gene[type+"_"+tmp[0]] = tmp[1][1:-1]

f = open(asstat,"r").readlines()
tps =f[0].strip().split()[1:]
cts = f[1].strip().split()[1:]
fts = [0,0,0,0,0]
gene_as = defaultdict(lambda:[0,0,0,0,0,0])  #for each gene: A3SS A5SS MXE RI SE, pass_tpm_filter(1:yes, 0:no)
type_idx = {"A3SS":0, "A5SS":1, "MXE":2, "RI":3, "SE":4}
for file in psifilteredfiles.strip(",").split(","):
    type = file.split("/")[-1].split(".")[0]
    i = 0
    with open(file) as f:
        f.readline()
        for line in f:
            i += 1
            tmp = line.split("\t")
            gene_as[as2gene[tmp[0]]][type_idx[type]] += 1
    fts[tps.index(type)] = i
txt = "type\tbefore\tafter\n"
for i in range(5):
    txt += tps[i]+"\t"+cts[i]+"\t"+str(fts[i])+"("+str(round(fts[i]*100.0/int(cts[i]),2))+"%)"+"\n"
open(outdir+"/AS_PSI_fulter.stat.txt","w").write(txt)

txt = "gene\tA3SS\tA5SS\tMXE\tRI\tSE\tpass_tpm_filter\n"
for k,v in gene_as.items():
    if k in gene_pass_tpm_filter:
        v[5] = 1
        txt += k+"\t"+"\t".join(map(str,v))+"\n"
    else:
        v[5] = 0
        txt += k+"\t"+"\t".join(map(str,v))+"\n"
open(outdir+"/gene_AS_count.txt","w").write(txt)