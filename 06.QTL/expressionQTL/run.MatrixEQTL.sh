#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/expressionQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/expressionQTL/run.MatrixEQTL.R
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
