#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=12:00:00

mamba activate QAA

/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/fastqc

/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/fastqc

/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/fastqc

/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/fastqc


mamba deactivate