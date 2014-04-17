 
#!/bin/bash -login
 
# Torque/PBS Job Script for MathKernel on HPCC Systems
#
# 2010/11/16 - Eric McDonald
# * Create.
 
#PBS -N Mathematica-v1
#PBS -l nodes=1:ppn=4,mem=64gb,walltime=720:00:00
#PBS -m ae
#PBS -W x=gres:MathKernel+1
 
module load Mathematica
 
cd $PBS_O_WORKDIR
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"
 
echo "Started batch processing at `date`."
math -noprompt -run '<<KEACT_v1.m'
echo "Ended batch processing at `date`."
 
exit 0