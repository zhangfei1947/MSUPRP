# -t time
# -N nodes needed
# -n number of tasks
# -c number of CPUs (or cores) per task 
# --mem-per-cpu
# -J job name
sbatch -t 4:00:00 -N 1 -n 6 -c 1 --mem-per-cpu 4G -J AS 01.02.rMATS_statoff_originalGTF.job

