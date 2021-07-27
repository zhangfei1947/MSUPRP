
import sys,glob

requantdir = sys.argv[1]
allgtfs = glob.glob(requantdir+"/*stringtie.gtf")  #exclude 1833 sample
allgtfs.remove(requantdir+"/1833.stringtie.gtf")
out = requantdir+"/transcript_tpm.txt"
txt = []
txt.append(["transcript",])
with open(allgtfs[0]) as f:
        for line in f:
            if "\ttranscript\t" in line:
                tmp = line.strip().split("\t")[-1].split(" ")
                txt[-1].append(tmp[3])

for gtf in allgtfs:
    print gtf
    txt.append([gtf.split("/")[-1].split(".")[0]])
    with open(gtf) as f:
        for line in f:
            if "\ttranscript\t" in line:
                tmp = line.strip().split("\t")[-1].split(" ")
                txt[-1].append(tmp[-1])

txt = "\n".join(["\t".join(each) for each in txt]) + "\n"
txt = txt.replace(";","").replace('"','')
open(out,"w").write(txt)