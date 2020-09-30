import glob
gff = '/mnt/home/zhangf37/Genomic/Sus_scrofa/ensembl_release97/Sus_scrofa.Sscrofa11.1.97.gff3'
#dir1= '/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/24sample_PE100/'
dir2='/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/07.StringTie/144sample_stranded_PE125/'
out_file = 'known_gene_TPM'

gene_list = []
dic_gene_index = {}
TPM_list = []
i = 0

with open(gff) as f:
    for line in f:
        if line[0] != '#':
            tmp = line.split('\t')
            if tmp[2].endswith('gene'):
                gene = tmp[8].split(';')[0].replace('ID=gene:','')
                gene_list.append(gene)
                dic_gene_index[gene] = i
                i += 1
                TPM_list.append(['0.0']*144)

sample_list = []
#files_1 = sorted(glob.glob(dir1+'*.gene_abund.txt'))
files_2 = sorted(glob.glob(dir2+'*.gene_abund.txt'))
#for each in files_1:
#    sample_list.append(each.replace(dir1,'').replace('.gene_abund.txt',''))
for each in files_2:
    sample_list.append('X'+each.replace(dir2,'').replace('.gene_abund.txt',''))

i = 0
#for each in files_1:
#    with open(each) as f:
#        for line in f:
#            if line.startswith('ENSS'):
#                tmp = line.strip().split('\t')
#                TPM_list[dic_gene_index[tmp[0]]][i] = str(float(tmp[8]))
#    i += 1

for each in files_2:
    with open(each) as f:
        for line in f:
            if line.startswith('ENSS'):
                tmp = line.strip().split('\t')
                TPM_list[dic_gene_index[tmp[0]]][i] = str(float(tmp[8]))
    i += 1


txt = 'sample\t' + '\t'.join(sample_list) + '\n'
i = 0
for line in TPM_list:
    txt += gene_list[i]+'\t' + '\t'.join(line) + '\n'
    i += 1
open(out_file,'w').write(txt)

txt = 'sample\t' + '\t'.join(sample_list) + '\n'
i = 0
for line in TPM_list:
    if line.count('0.0') <= 116:
        txt += gene_list[i]+'\t' + '\t'.join(line) + '\n'
    i += 1
open(out_file+'.filter28','w').write(txt)



