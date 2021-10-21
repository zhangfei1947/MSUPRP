## summarize QTL FDR results

import sys,glob

qtldir = sys.argv[1] #contains geneID.fastGWA.fdr files
genelocfile = sys.argv[2]
outdir = sys.argv[3]

#prepare gene loc information
geneloc = {}
with open(genelocfile) as f:
    f.readline()
    for line in f:
        tmp = line.strip("\n").split("\t")
        geneloc[tmp[0]] = "\t".join(tmp[1:])

print "1 done"
#txt = "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % ("gene", "chr", "strand", "start", "end", "snpchr", "snp", "pos", "pvalue", "FDR")
txt = "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" % ("AS","gene", "chr", "strand", "start", "end","ASstart","ASend", "snpchr", "snp", "pos", "pvalue", "FDR")
fdrfiles = glob.glob(qtldir+"/*fastGWA.fdr")
i = 0
for fdrfile in fdrfiles:
    i += 1
    print i,fdrfile
    geneid = fdrfile.split("/")[-1].replace(".fastGWA.fdr","")
    with open(fdrfile) as f:
        for line in f:
            tmp = line.strip("\n").split("\t")
            if float(tmp[-1]) <= 0.05: #FDR <= 0.05 
                txt += geneid + "\t" + geneloc[geneid] + "\t" + line

open(outdir+"/QTL.results.txt","w").write(txt)