#!/bin/bash -login
 
# Torque/PBS Job Script for MathKernel on HPCC Systems
#
# 2010/11/16 - Eric McDonald
# * Create.
 
#PBS -N ssc_run
#PBS -l nodes=1:ppn=6,walltime=720:00:00
#PBS -m ae


cd $PBS_O_WORKDIR
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"
 
echo "Started batch processing at `date`."
math -script ssc.m
echo "Ended batch processing at `date`."
 
exit 0
