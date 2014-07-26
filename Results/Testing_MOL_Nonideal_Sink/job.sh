#!/bin/bash -login
 
#PBS -N att_rd_05
#PBS -l nodes=1:ppn=4,walltime=720:00:00
#PBS -m ae
 
cd $PBS_O_WORKDIR
 
echo "Information about the job:"
qstat -f $PBS_JOBID
echo -e "\n\n"

rm att_rd_05.*
rm *.tsv
rm *.out
rm *.pdf
rm done.txt
 
echo "Started batch processing at `date`."
math -script numeric_integration.m
echo "mathematica finished at `date`."
python plot0.py

echo 'done'>done.txt

exit 0
