In this project we are processing RNA-seq reads
The two SRA numbers I am working with are

SRR25630312     
SRR25630410     

cloned my forked git repo "Ryan_QAA" to my Talapas projects folder
In this repo created a new folder SRR_stuff to hold files from this and subsequent steps

To get and open up the SRR files, creating a new folder for each of the fastq files produced. Ran these in the SRR_stuff directory:
```
prefetch SRR25630312
prefetch SRR25630410

fasterq-dump SRR25630312 -O /SRR25630312_files
fasterq-dump SRR25630410 -O /SRR25630410_files
```
This produces an R1 and R2 fastq file for each of the SRR#'s
All 4 files were zipped using gzip

## part 1 quality analysis

Now for quality analysis, installing some necessary packages and making an environment. environment named "QAA" and installing fastqc, cutadapt, and trimmomatic here with versions displayed as well
```
 srun --account=bgmp --partition=bgmp --time=1:00:00 --pty bash
 mamba create -n QAA
 mamba activate QAA
 
 mamba install fastqc
 mamba install bioconda::cutadapt
mamba install bioconda::trimmomatic

fastqc --version
FastQC v0.12.1

cutadapt --version
5.1

trimmomatic -version
0.40

```
### fastqc
The next step is to do quality assessment with fastqc:
submitted the following as an sbatch script in order to produce a fastqc analysis file for each of the four SRR fastq files

this file is the fastqc_sbatch.sh file in the code folder 
```
fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/fastqc


/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/fastqc

  
/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/fastqc


/usr/bin/time -v fastqc /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/fastqc

```
all files created successfully

one of the time results from the sbatch (rest are similar). 
User time (seconds): 228.34
System time (seconds): 12.41
Percent of CPU this job got: 98%
Elapsed (wall clock) time (h:mm:ss or m:ss): 4:04.94

full information available in slurm-37956261.out file

### my python qc
Now doing quality assessment with my qc distribution python program made previously for the demultiplexing assignment

updated my code for my mean quality distribution Python program to include argparse. This is so I can run an sbatch script and create plots for all 4 fastq files. 
placed all commands in the my_qc_sbatch.sh file
```
/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz -n SRR25630312_1 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/my_qc


/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz -n SRR25630312_2 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/my_qc


/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz -n SRR25630410_1 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/my_qc


/usr/bin/time -v ./score_distribution.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz -n SRR25630410_2 -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/my_qc
```
ran the sbatch for my qc distributions

all plots generated successfully

one of the time results:
User time (seconds): 833.20
System time (seconds): 0.30	
Percent of CPU this job got: 99%
Elapsed (wall clock) time (h:mm:ss or m:ss): 13:57.30

full information available in the slurm-37956423.out file

### analysis
The plots show the same means with the same trends per base pair between the reads for both the fastqc generated and Python generated plots. The fastqc plots also show error bars. The Python generated plots took way longer to generate as they took around 14 minutes each while the fastqc plots took around 4. The fastqc output also includes a multitude of other plots and information so is a lot more efficient in terms of both time and usefulness. The fastqc program is not written in Python and can therefore be faster.


The data quality across all four files is good and ready for further analysis. The per base quality score distribution for each file is very good with the average quality per read peaking highly at 36 for each file. Accordingly, the per base N content is also nonexistent or very low for each file. The GC content for each file also seems to be normally distributed which is a good sign. All the sequence lengths look to be uniform at 150 bp for each file. 





## Moving on to part 2, cutadapt and trimmomatic

For trimming. cutadapt and trimmomatic installed as shown above.


to confirm adapter sequences used grep to check the files for their presence.
R1: `AGATCGGAAGAGCACACGTCTGAACTCCAGTCA`
R2: `AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT`

```
zcat SRR25630312_1.fastq.gz | head -5000 | grep "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"

zcat SRR25630312_2.fastq.gz | head -5000 | grep "AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT"

```
The adapters are present in their respective files towards the 3' ends of the sequences. They seem to be oriented as is while both of these commands show multiple hits while the adapters are not present in the other files. 


### Cutadapt
Created an sbatch file for the cutadapt commands for each file
cutadapt_sbatch.sh
```
/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --cores 8 \

    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_1.fastq.gz\

    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_1.fastq.gz

  

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cores 8\ -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/cutadapt/cut_SRR25630410_2.fastq.gz\

    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/SRR25630410_2.fastq.gz

  

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --cores 8\

    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_1.fastq.gz\


/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_1.fastq.gz

  

/usr/bin/time -v cutadapt -a AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --cores 8\

    -o /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/cutadapt/cut_SRR25630312_2.fastq.gz\

    /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/SRR25630312_2.fastq.gz


```
all files processed and created trimmed files successfully

example time output:
User time (seconds): 285.47
System time (seconds): 23.82
Percent of CPU this job got: 565%
Elapsed (wall clock) time (h:mm:ss or m:ss): 0:54.69

full results are available in the slurm-38045319.out file

#### cutadapt counts
using cutadapt to cut out adaptor sequences
Here are the counts for the number of reads trimmed for each file

for SRR25630410-1
Total reads processed:              46,517,521
Reads with adapters:                 7,974,683 (17.1%)
Reads written (passing filters):    46,517,521 (100.0%)


for SRR25630410-2
Total reads processed:              46,517,521
Reads with adapters:                 7,880,872 (16.9%)
Reads written (passing filters):    46,517,521 (100.0%)


for SRR25630312-1
Total reads processed:              45,399,171
Reads with adapters:                 5,929,976 (13.1%)
Reads written (passing filters):    45,399,171 (100.0%)


for SRR25630312-2
Total reads processed:              45,399,171
Reads with adapters:                 6,185,330 (13.6%)
Reads written (passing filters):    45,399,171 (100.0%)


### Trimmomatic
after  adaptors are cut out
Using the 4 cut files from the cutadapt outputs.
trimming low quality base pairs and portions

again created an sbatch script to hold commands. in this case trimmomatic takes in both the R1 and R2 files for a command while giving back out 4 files for paired and unpaired forward and paired and unpaired reverse.

so created two commands in the trimmomatic_sbatch.sh file, one for each SRR#

used these parameters for each too . order is important as the commands will be performed in that order:
HEADCROP: 8 bases. LEADING: quality of 3. TRAILING: quality of 3, SLIDING WINDOW: window size of 5 and required quality of 15, MINLENGTH: 35 bases

headcrop =removes a set amount of bases from start of reads. leading = cuts bases off the start of a read that are below a threshold, trailing is for the end of read. sliding window goes through the reads and cuts when the average quality of the window is below a threshold. minlength just gets rid of the reads that are below that length. 
```
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


```

After running the sbatch for trimmomatic, all files are successfully created
time results:
User time (seconds): 3688.84
System time (seconds): 41.28
Percent of CPU this job got: 574%
Elapsed (wall clock) time (h:mm:ss or m:ss): 10:48.97

full information in slurm-38045504.out




#### trim length plots

getting the counts of read lengths of all sequences after trimming for each file

```
zcat output_forward_paired_SRR25630410.fq.gz | awk 'NR%4==2 {print $1}' | awk '{print length($1)}' | sort | uniq -c > 410_forward_counts.txt
  
zcat output_reverse_paired_SRR25630410.fq.gz | awk 'NR%4==2 {print $1}' | awk '{print length($1)}' | sort | uniq -c > 410_reverse_counts.txt

zcat output_forward_paired_SRR25630312.fq.gz | awk 'NR%4==2 {print $1}' | awk '{print length($1)}' | sort | uniq -c > 312_forward_counts.txt

zcat output_reverse_paired_SRR25630312.fq.gz | awk 'NR%4==2 {print $1}' | awk '{print length($1)}' | sort | uniq -c > 312_reverse_counts.txt

```

making plots for dsitributions in python
created trim_length_distributions.py and made bar charts to compare R1 and R2 trim lengths

from the data it seems that R1 is trimmed slightly more than R2 for SRR25630312, with the difference between the two being greater in SRR25630410. In both cases then, R1 is being trimmed at a higher rate. This makes sense when taking the quality score assessment for each read file into account. For SRR25630312 the quality score distributions are very similar between R1 and R2, so they are both quality trimmed somewhat equally. The quality scores per base pair for R1 in SRR25630410 are notably lower than R2 and thus is trimmed to a further extent. 


## Part 3
first installing packages
```
mamba install STAR
STAR --version
2.7.11b

mamba install picard=2.18
picard MarkDuplicates --version
2.18.29-SNAPSHOT

mamba install samtools
samtools --version
samtools 1.22.1

mamba install numpy
1.26.4 (from mamba list)

mamba install matplotlib
3.10.6 (from mamba list)

mamba install htseq
2.0.9 (from mamba list)

```


download wasn't working for _Campylomormyrus compressirostris_ genome fasta and gff file
used the ones available from talapas.
### STAR database creation and alignment
to generate the alignment database, had to convert the gff file to gtf. used the "AGAT" package
and followed the documentation. 
```
agat_convert_sp_gff2gtf.pl --gff campylomormyrus.gff -o campylomormyrus.gtf
```

output a gtf file for use in creating the alignment database.

generated the alignment database. used sbatch script: star_build_db.sh
```
/usr/bin/time -v STAR --runThreadN 8 --runMode genomeGenerate \

    --genomeDir /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.dna.STAR \

    --genomeFastaFiles /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/Cac/campylomormyrus.fasta \

    --sjdbGTFfile /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/campylomormyrus.gtf

```
script ran successfully
User time (seconds): 1435.07
System time (seconds): 26.38
Percent of CPU this job got: 377%
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:26.78


Next Aligning the reads to the generated alignment database
used sbatch script star_align_reads.sh
```
  

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

```
alignments created correctly


next up, sorting the sam files before moving forward.
ran in an interactive session
```

samtools sort SRR25630312_Aligned.out.sam -o sorted_SRR25630312.sam

samtools sort SRR25630410_Aligned.out.sam -o sorted_SRR25630410.sam
```


### Picard 

Next running Picard to remove PCR duplicates
```
/usr/bin/time -v picard MarkDuplicates INPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/sorted_SRR25630312.sam\

    OUTPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picard_SRR25630312.sam\

    METRICS_FILE=./SRR25630312/picardstuff.metrics REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT

  

/usr/bin/time -v picard MarkDuplicates INPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/sorted_SRR25630410.sam\

    OUTPUT=/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picard_SRR25630410.sam\

    METRICS_FILE=./SRR25630410/picardstuff.metrics REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT
```


Now using the SAM_parser.py script to report the number of mapped and umapped reads from the 2 sam files after being processed with Picard. running the following commands in the code directory with the SAM_parser.py file
```
./SAM_parser.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/picard_SRR25630312.sam

./SAM_parser.py -f /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/picard_SRR25630410.sam
```

SRR25630312
mapped reads - 37341592
unmapped reads - 16674535

SRR25630410
mapped reads - 29216546
unmapped reads - 29857662

### HTSeq-Count
Finally running htseq-count to count the reads that map to features in the sam file

using the output picard files

tried to run htseq with the gtf files. kept getting error "The attribute string seems to contain mismatched quotes." it turns out I can use gff file instead, so will go to that and set -i to Parent and see if that works

```
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

```
htseq ran successfully. 

now counting the reads that reads that are mapped to features
```
head -n -5 /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/htseq_counts_yes_SRR25630312.tsv | awk '{s+=$2} END {print s}'
593376

head -n -5 /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630312/htseq_counts_reverse_SRR25630312.tsv | awk '{s+=$2} END {print s}'
10877058

head -n -5 /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/htseq_counts_yes_SRR25630410.tsv | awk '{s+=$2} END {print s}'
483234

head -n -5 /projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/part3/SRR25630410/htseq_counts_reverse_SRR25630410.tsv | awk '{s+=$2} END {print s}'
8607298

```
