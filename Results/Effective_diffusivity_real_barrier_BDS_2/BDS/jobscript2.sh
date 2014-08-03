#!/bin/bash -login
 
# Torque/PBS Job Script for MathKernel on HPCC Systems
#
# 2010/11/16 - Eric McDonald
# * Create.
 
#PBS -N attrun_test
#PBS -l nodes=1:ppn=4,walltime=720:00:00
#PBS -m ae

export OMP_NUM_THREADS = 8

cd $PBS_O_WORKDIR

rm *data*
rm attrung_test.*
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"
 
echo "Started batch processing at `date`."
python msq_analysis.py
echo "Ended batch processing at `date`."
 
exit 0
