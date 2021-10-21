
eqtl_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/01.eQTL/QTLs_distribution_in_chr/plot.qtls.distri.tmp.txt"
sqtl_file = "/mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/05.mappingQTL/02.sQTL/QTLs_distribution_in_chr/plot.qtls.distri.tmp.txt"

eqtl_tss = []
eqtl_tes = []
with open(eqtl_file) as f:
    for line in f:
        tmp = line.split("\t")
        if tmp[5] != "NA":
            if int(tmp[5]) > -40000 and int(tmp[5]) < 4000:
                eqtl_tss.append(int(tmp[5]))
        elif tmp[6] != "NA":
            if int(tmp[6]) > -4000 and int(tmp[6]) < 40000:
                eqtl_tes.append(int(tmp[6]))

sqtl_tss = []
sqtl_tes = []
with open(sqtl_file) as f:
    for line in f:
        tmp = line.split("\t")
        if tmp[5] != "NA":
            if int(tmp[5]) > -40000 and int(tmp[5]) < 4000:
                sqtl_tss.append(int(tmp[5]))
        elif tmp[6] != "NA":
            if int(tmp[6]) > -4000 and int(tmp[6]) < 40000:
                sqtl_tes.append(int(tmp[6]))

#total_eqtl = len(eqtl_tss) + len(eqtl_tes)
#total_sqtl = len(sqtl_tss) + len(sqtl_tes)

eqtl_tss_bins = [0]*22 #-40k~-38k~-36k...TSS~2k~4k
for point in eqtl_tss:
    index = int((point+40000)/2000)
    eqtl_tss_bins[index] += 1

eqtl_tes_bins = [0]*22 #-40k~-38k~-36k...tes~2k~4k
for point in eqtl_tes:
    index = int((point+4000)/2000)
    eqtl_tes_bins[index] += 1


sqtl_tss_bins = [0]*22 #-40k~-38k~-36k...TSS~2k~4k
for point in sqtl_tss:
    index = int((point+40000)/2000)
    sqtl_tss_bins[index] += 1

sqtl_tes_bins = [0]*22 #-40k~-38k~-36k...tes~2k~4k
for point in sqtl_tes:
    index = int((point+4000)/2000)
    sqtl_tes_bins[index] += 1

#print eqtl_tss_bins
#print sum(eqtl_tss_bins)
#print sum(eqtl_tes_bins)

points = ""
x_unit = 20
y_unit = 15
tmp_point = ""
for i in range(22):
    color = "rgb(255,99,71)"
    x_add_index = 0
    x = (x_add_index + i)*x_unit + 50
    y = 500 - eqtl_tss_bins[i]*y_unit
    points += '''<circle cx="%s" cy="%s" r="4" style="fill:%s"/>\n''' % (x,y,color)
    tmp_point += str(x)+","+str(y)+" "
points = '''<polyline points="%s" style="fill:none;stroke:rgb(255,99,71);stroke-width:2" />''' % (tmp_point) + points

tmp_point = ""
for i in range(22):
    color = "rgb(255,99,71)"
    x_add_index = 23
    x = (x_add_index + i)*x_unit + 50
    y = 500 - eqtl_tes_bins[i]*y_unit
    points += '''<circle cx="%s" cy="%s" r="4" style="fill:%s"/>\n''' % (x,y,color)
    tmp_point += str(x)+","+str(y)+" "
points = '''<polyline points="%s" style="fill:none;stroke:rgb(255,99,71);stroke-width:2" />''' % (tmp_point) + points

tmp_point = ""
for i in range(22):
    color = "rgb(30,144,255)"
    x_add_index = 0
    x = (x_add_index + i)*x_unit + 50
    y = 500 - sqtl_tss_bins[i]*y_unit
    points += '''<circle cx="%s" cy="%s" r="4" style="fill:%s"/>\n''' % (x,y,color)
    tmp_point += str(x)+","+str(y)+" "
points = '''<polyline points="%s" style="fill:none;stroke:rgb(30,144,255);stroke-width:2;stroke-dasharray:5,5" />''' % (tmp_point) + points

tmp_point = ""
for i in range(22):
    color = "rgb(30,144,255)"
    x_add_index = 23
    x = (x_add_index + i)*x_unit + 50
    y = 500 - sqtl_tes_bins[i]*y_unit
    points += '''<circle cx="%s" cy="%s" r="4" style="fill:%s"/>\n''' % (x,y,color)
    tmp_point += str(x)+","+str(y)+" "
points = '''<polyline points="%s" style="fill:none;stroke:rgb(30,144,255);stroke-width:2;stroke-dasharray:5,5" />''' % (tmp_point) + points


##write svg
svg = '''<svg xmlns="http://www.w3.org/2000/svg" version="1.1">

<style>
    line {
        stroke-width:2;
        stroke:rgb(0,0,0);
    }

    circle {
        stroke-width:0;
    }
</style>


<line x1="40" y1="500" x2="950" y2="500" />
<line x1="40" y1="500" x2="40" y2="100" />

<style>
    text {
        text-anchor:end;
        font-size:14;
        fill:rgb(0,0,0)
    }
</style>
<line x1="37" x2="40" y1="500" y2="500" />
<text x="35" y="500" >0</text>


%s


</svg>
''' % (points)

open("qtls.distri.svg","w").write(svg)