import numpy as np
infile='stringtie_144_sample.tracking'
output='isoform_TPM'
txt = ''
with open(infile) as f:
    for line in f:
        tmp = line.strip().split('\t')
        tpm_list = [0]*144
        tpm_list_for_sd = []
        num_sp = 0
        sd = 0
        for i in range(4,148):
            if '|' in tmp[i]:
                tpm = float(tmp[i].split('|')[4])
                tpm_list[i-4] = tpm
                tpm_list_for_sd.append(tpm)
                num_sp += 1
        tpm_list_for_sd = np.array(tpm_list_for_sd)
        sd = tpm_list_for_sd.std()
        txt += '\t'.join(tmp[:4])+'\t'+str(num_sp)+'\t'+str(sd)+'\t'+'\t'.join(map(str,tpm_list))+'\n'
open(output,'w').write(txt)
