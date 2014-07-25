#!/bin/bash -login
 
# Torque/PBS Job Script for MathKernel on HPCC Systems
#
# 2010/11/16 - Eric McDonald
# * Create.
 
#PBS -N Ks_scan_r_v2
#PBS -l nodes=1:ppn=4,walltime=720:00:00
#PBS -m ae


cd $PBS_O_WORKDIR
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"
 
echo "Started batch processing at `date`."
math -script rep_numerics.m
echo "Ended batch processing at `date`."
 
exit 0
