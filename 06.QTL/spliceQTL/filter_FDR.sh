#!/bin/bash

output=$1".FDR_1e-4"
`head -n 1 $1 > $output`
`awk '$6<1e-4 ' $1 >> $output`
