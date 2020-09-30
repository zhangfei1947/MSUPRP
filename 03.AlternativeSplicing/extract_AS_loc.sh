#!/bin/bash

`sed 1d fromGTF.SE.txt|awk '{print"SE_"$1"\t"$4"\t"$6"\t"$7}' > SE.loc.txt`
`sed 1d fromGTF.RI.txt|awk '{print"RI_"$1"\t"$4"\t"$6"\t"$7}' > RI.loc.txt`
`sed 1d fromGTF.A5SS.txt|awk '{print"A5SS_"$1"\t"$4"\t"$6"\t"$7}' > A5SS.loc.txt`
`sed 1d fromGTF.A3SS.txt|awk '{print"A3SS_"$1"\t"$4"\t"$6"\t"$7}' > A3SS.loc.txt`
`sed 1d fromGTF.MXE.txt|awk '{print"MXE_"$1"\t"$4"\t"$6"\t"$9}' > MXE.loc.txt`
