infile = 'isoform_TPM'
outfile = 'isoform_TPM_ratio'
sample_file = 'input_gtf_list'

out_list = []
LOC = ''
tmp_list = []

def cal_iso_precent(tmp_list,out_list):
    if len(tmp_list) > 1:
        tmp_list2 = []
        l = len(tmp_list)
        for iso_i in range(l):
            tmp_list2.append(['0']*145)
            tmp_list2[-1][0] = tmp_list[iso_i][0]
        for i in range(1,145):
            sum_tpm = 0
            for iso_i in range(l):
                sum_tpm += float(tmp_list[iso_i][i])
            if sum_tpm > 0.2:
                for iso_i in range(l):
                    tmp_list2[iso_i][i] = str(round((float(tmp_list[iso_i][i])*100/sum_tpm),2))
        out_list += tmp_list2


with open(infile) as f:
    for line in f:
        tmp = line.strip().split('\t')
        if tmp[1] != LOC:
            cal_iso_precent(tmp_list,out_list)
            tmp_list = [[tmp[0]+'_'+tmp[1]]+tmp[6:]]
            LOC = tmp[1]
        else:
            tmp_list.append([tmp[0]+'_'+tmp[1]]+tmp[6:])
    cal_iso_precent(tmp_list,out_list)

txt = 'sample'
with open(sample_file) as f:
    for line in f:
        txt += '\tX' + line.strip().split('/')[-1].replace('.stringtie.gtf','')
txt += '\n'
for line in out_list:
    txt += '\t'.join(line) + '\n'
open(outfile,'w').write(txt)

