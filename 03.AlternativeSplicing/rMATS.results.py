import sys,glob
from collections import defaultdict
indir = sys.argv[1]
dic = defaultdict(list)
#total  annotated   novel
total_files = glob.glob(indir+'/fromGTF.*.txt')
for eachfile in total_files:
    num = len(open(eachfile,'rU').readlines()) - 1 
    tmp = eachfile.split('/')[-1].split('.')
    SpliceType = tmp[-2]
    if num != 0:
        dic[SpliceType].append(num)

txt = 'AS\ttype\tcount\n'
for k,v in dic.items():
    total = max(v)
    novel = min(v)
    anno = total - novel
    txt += '%s\t%s\t%s\n' % (k,'Annotated',anno)
    txt += '%s\t%s\t%s\n' % (k,'NovelJunction',novel)
open('rMATs_stat.txt','w').write(txt)

