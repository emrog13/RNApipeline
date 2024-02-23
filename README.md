# RNApipeline
HPCC coding pipeline for transcriptomics, differential expression analyses for plant and fungi

```
gitclone https://github.com/emrog13/RNApipeline/
```

## Install packages with conda
```
conda create --name RNApipeline
conda activate RNApipeline
conda install cutadapt   #install all packages listed below
```
cutadapt, fastqc, htseq, hisat2, samtools

## Download reference genome fasta and gtf files
Zea mays NAM v.5 from Ensembl

Place in genome folder

## Edit config file
Hard code names and locations for your genome and gtf files
If needing to index the genome, have hisat_index=yes option

## Optional: Edit sbatch files
Edit the options for cutadapt, hisat, and htseq.

### Important Option!
The strandedness of your RNAseq libraries may need to be changed. Currently set to reverse/second stranded for hisat and htseq for use on Illumina stranded mRNA libraries, TruSeq.

## Running Pipeline
Once pre-requisites are set. Place raw read files in rawdata folder. My raw reads files had names of {SAMPLE}_R1.fq.gz and {SAMPLE}_R2.fq.gz. for forward and reverse reads per sample. You may need to change the names and/or code if naming is different.
To run go to project directory with config.yaml and RNApipeline.sh file and run:
```
./RNApipeline.sh
```
## Acknowledgments
Pipeline designed and edited from https://github.com/Gian77/Cecilia 

