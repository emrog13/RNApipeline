# RNApipeline
Coding pipeline for transcriptomics, differential expression analyses for plant and fungi

## Install packages with conda
```
conda create --name RNApipeline
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

