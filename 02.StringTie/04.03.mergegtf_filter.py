
##$gtffile $transcriptfile $outdir

import sys,re
gtffile = sys.argv[1]
transcriptfile = sys.argv[2]
outdir = sys.argv[3]

filter_gtf = outdir+"/stringtie_merge.filter.gtf"
filter_gtf = open(filter_gtf,"w")
anno_gtf = outdir+"/stringtie_merge.filter.anno.gtf"
anno_gtf = open(anno_gtf,"w")

iso_set = set()
anno_set = set()
with open(transcriptfile) as f:
    f.readline()
    for line in f:
        tmp = line[:40].split("\t")
        if tmp[1] == "=":
            anno_set.add(tmp[0])
        iso_set.add(tmp[0])

write_filter = 0
write_anno = 0
with open(gtffile) as f:
    for line in f:
        if "\ttranscript\t" in line:
            write_filter = 0
            write_anno = 0
            m = re.search('transcript_id "([\w.]+)";',line)
            iso = m.group(1)
            if iso in iso_set:
                write_filter = 1
                if iso in anno_set:
                    write_anno = 1
        if write_filter:
            filter_gtf.write(line)
        if write_anno:
            anno_gtf.write(line)

filter_gtf.close()
anno_gtf.close()