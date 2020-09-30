#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/spliceQTL/run.MatrixEQTL.R SE
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/spliceQTL/run.MatrixEQTL.R RI
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/spliceQTL/run.MatrixEQTL.R MXE
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/spliceQTL/run.MatrixEQTL.R A3SS
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
#!/bin/bash --login
cd /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/06.QTL/spliceQTL
Rscript /mnt/scratch/zhangf37/PROJECT/20190813_MSUPRP/00.Scripts/06.QTL/spliceQTL/run.MatrixEQTL.R A5SS
scontrol show job $SLURM_JOB_ID >> run_sQTL.log
