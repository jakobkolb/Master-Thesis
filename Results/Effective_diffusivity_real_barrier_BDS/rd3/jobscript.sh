#!/bin/bash -login
 
# Torque/PBS Job Script for MathKernel on HPCC Systems
#
# 2010/11/16 - Eric McDonald
# * Create.
 
<<<<<<< HEAD
#PBS -N rd3
=======
#PBS -N attrun_test
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6
#PBS -l nodes=1:ppn=4,walltime=720:00:00
#PBS -m ae

export OMP_NUM_THREADS = 8

cd $PBS_O_WORKDIR

rm *data*
rm attrung_test.*
rm trajectories.*
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"

cp Parameters.equil Parameters.in
echo "Started equilibration at `date`."
./BDS
cp Parameters.relax Parameters.in
echo "Started relaxation at `date`."
./BDS
echo "Started msq analysis `date`."
python msq_analysis.py
echo "Ended batch processing at `date`."
rm trajectories.txt
exit 0
