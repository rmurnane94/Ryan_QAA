#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00

mamba activate QAA


#htseq-count [options] <alignment_files> <gtf_file>

/usr/bin/time -v htseq-count -s yes -r pos -t exon -i Parent\
    -c /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/htseq_counts_yes_SRR25630312.tsv\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picard_SRR25630312.sam\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gff

/usr/bin/time -v htseq-count -s reverse -r pos -t exon -i Parent\
    -c /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/htseq_counts_reverse_SRR25630312.tsv\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picard_SRR25630312.sam\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gff

/usr/bin/time -v htseq-count -s yes -r pos -t exon -i Parent\
    -c /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/htseq_counts_yes_SRR25630410.tsv\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picard_SRR25630410.sam\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gff

/usr/bin/time -v htseq-count -s reverse -r pos -t exon -i Parent\
    -c /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/htseq_counts_reverse_SRR25630410.tsv\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picard_SRR25630410.sam\
    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gff


mamba deactivate