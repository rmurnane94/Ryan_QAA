#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8

mamba activate QAA

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --cores 8 \
    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_1.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cores 8\
    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_2.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --cores 8\
    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_1.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cores 8\
    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_2.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz


mamba deactivate