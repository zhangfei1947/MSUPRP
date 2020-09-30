ingtf = '144sample_stringtie_merge.gtf'
outgtf = 'original_transcripts_in_144sample_stringtie_merge.gtf'
listfile = 'complete_match_transcripts.list'

tlist = open(listfile,'r').read().strip().split() 
dic = {}
with open(ingtf) as f:
    txt = f.readline()
    txt += f.readline()
    for line in f:
        tmp = line.split()
        if tmp[2] == 'transcript':
            key = tmp[11]
            dic[key] = line
        else:
            dic[key] += line

for t in tlist:
    txt += dic['"'+t+'";']

open(outgtf,'w').write(txt)

