input_gtf = '144sample_stringtie_merge.gtf'
selected_type = 'tmap.selected.type.list'

dic = {}
t_list = open(selected_type,'r').read().strip().split()

for t in t_list:
    dic[t] = 1

outtxt = ''
with open(input_gtf) as f:
    outtxt += f.readline()
    outtxt += f.readline()
    write_flag = 0
    for line in f:
        tmp = line.rstrip('\n').split()
        if tmp[2] == 'transcript':
            if tmp[11].strip(';').strip('"') in dic:
                write_flag = 1
            else:
                write_flag = 0
        if write_flag == 1:
            outtxt += line

open('144sample_stringtie_merge.selected.gtf','w').write(outtxt)
        



