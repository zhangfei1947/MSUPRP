#!/bin/bash

output=$1".h2_0.25_fdr_0.05"
#`head -n 1 $1 > $output`
`sed 1d $1 | awk '$2>0.25&&$5<0.05' > $output`
