#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00

mamba activate QAA

/usr/bin/time -v picard MarkDuplicates INPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/sorted_SRR25630312.sam\
    OUTPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picard_SRR25630312.sam\
    METRICS_FILE=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picardstuff.metrics REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT

/usr/bin/time -v picard MarkDuplicates INPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/sorted_SRR25630410.sam\
    OUTPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picard_SRR25630410.sam\
    METRICS_FILE=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picardstuff.metrics REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT

mamba deactivate
