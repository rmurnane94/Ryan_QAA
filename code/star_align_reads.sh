#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00


mamba activate QAA

/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_forward_paired_SRR25630312.fq.gz' '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/output_reverse_paired_SRR25630312.fq.gz' \
    --genomeDir /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.dna.STAR \
    --outFileNamePrefix '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/SRR25630312_'


/usr/bin/time -v STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_forward_paired_SRR25630410.fq.gz' '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/output_reverse_paired_SRR25630410.fq.gz' \
    --genomeDir /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.dna.STAR \
    --outFileNamePrefix '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/SRR25630410_'

    # --readFilesCommand zcat \

mamba deactivate
# Bi623/Ryan_QAA/part3/campylomormyrus.dna.STAR