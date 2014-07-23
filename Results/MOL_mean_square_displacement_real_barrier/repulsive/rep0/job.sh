#!/bin/bash -login
 
#PBS -N rep_rd_05
#PBS -l nodes=1:ppn=4,walltime=720:00:00
#PBS -m ae
 
cd $PBS_O_WORKDIR
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"
 
echo "Started batch processing at `date`."
math -script numeric_integration.m
echo "mathematica finished at `date`."
python 2_Eff.py
echo "Ended batch processing at `date`."
 
exit 0
