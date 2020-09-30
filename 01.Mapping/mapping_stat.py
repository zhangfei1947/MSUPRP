import sys,os,glob,re

inpath = sys.argv[1]
infiles = glob.glob(inpath+'/*summary.txt')

outputtxt = 'sample,total reads,paired unique mapped reads,alignment rate,concordantly 1 time,concordantly >1 time\n'
for statfile in infiles:
    filename = statfile.split('/')[-1]
    samplename = filename.split('_')[-3]
    txt = open(statfile,'r').read()
    m = re.search('([^\s]+?) reads; of these:', txt)
    m1 = m.group(1)
    m = re.search('([^\s]+?) \(.+\) aligned concordantly exactly 1 time', txt)
    m2 = m.group(1)
    m = re.search('([^\s]+?%) overall alignment rate', txt)
    m3 = m.group(1)
    m = re.search('\((.+?%)\) aligned concordantly exactly 1 time', txt)
    m4 = m.group(1)
    m = re.search('\((.+?%)\) aligned concordantly >1 times', txt)
    m5 = m.group(1)
    outputtxt += '%s,%s,%s,%s,%s,%s\n' % (samplename, m1, m2, m3, m4, m5)

open('mappingstat.csv','w').write(outputtxt)
