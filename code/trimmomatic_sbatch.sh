#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=8

mamba activate QAA

/usr/bin/time -v trimmomatic PE -threads 8\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_1.fastq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_2.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_forward_paired_SRR25630410.fq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_forward_unpaired_SRR25630410.fq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_reverse_paired_SRR25630410.fq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_reverse_unpaired_SRR25630410.fq.gz\
    HEADCROP:8 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

/usr/bin/time -v trimmomatic PE -threads 8\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_1.fastq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_2.fastq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_forward_paired_SRR25630312.fq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_forward_unpaired_SRR25630312.fq.gz\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_reverse_paired_SRR25630312.fq.gz /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_reverse_unpaired_SRR25630312.fq.gz\
    HEADCROP:8 LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35



mamba deactivate

# /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files
# ./cutadapt/cut_SRR25630410_1.fastq.gz
# ./cutadapt/cut_SRR25630410_2.fastq.gz

# SRR25630312

# ./SRR25630410_files/trimmomatic/output_reverse_paired_SRR25630410.fq.gz
# ./SRR25630410_files/trimmomatic/output_reverse_unpaired_SRR25630410.fq.gz

# /usr/bin/time -v trimmomatic PE \
#     input_forward.fq.gz input_reverse.fq.gz \
#     output_forward_paired.fq.gz output_forward_unpaired.fq.gz \
#     output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz \
#     ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:35