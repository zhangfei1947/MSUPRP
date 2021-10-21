#!/bin/bash
sbatch -t 4:00:00 -N 1 -n 1 -c 1 --mem-per-cpu 10G -J rr 02.rrBLUP.genetpm.job