#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=12:00:00


mamba activate QAA

/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz -n SRR25630312_1 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/my_qc

/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz -n SRR25630312_2 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/my_qc



/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz -n SRR25630410_1 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/my_qc

/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz -n SRR25630410_2 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/my_qc

mamba deactivate