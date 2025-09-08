#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00

mamba activate QAA

/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \
    --genomeDir /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.dna.STAR \
    --genomeFastaFiles /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/Cac/campylomormyrus.fasta \
    --sjdbGTFfile /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gtf
    
mamba deactivate