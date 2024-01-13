#!/bin/bash -login

cat << "EOF"
                                    
EOF

echo -e "
RNA pipeline
email: roggenk4[at]msu[dot]edu
January 9, 2024
\n"

source ./config.yaml

cd $project_dir/rawdata/

echo -e "\n========== Comparing md5sum codes... ==========\n"

md5=$project_dir/rawdata/md5.txt

if [[ -f "$md5" ]]; then
		echo -e "\nAn md5 file exist. Now checking for matching codes.\n"
		md5sum md5* --check > tested_md5.results
		cat tested_md5.results
		resmd5=$(cat tested_md5.results | cut -f 2 -d" " | uniq)

		if [[ "$resmd5" == "OK" ]]; then
				echo -e "\n Good news! Files are identical. \n"
		else
				echo -e "\n Oh oh! You are in trouble. Your files are different from those at the source! \n"
				echo -e "\nSomething went wrong during files download. Try again, please.\n"
				exit
		fi
else
	echo "No md5 file was found. You should look for it, and start over again!"
fi

cd $project_dir/code/

echo -e "\n========== What I will do for you? Please see below... ==========\n"

echo -e "\n========== Prefiltering ==========\n" 

jid1=`sbatch 01_decompress-bash.sb | cut -d" " -f 4`
echo "$jid1: For starting, I will decompress your raw reads files."

jid2=`sbatch --dependency=afterok:$jid1 02_qualityCheck.sb | cut -d" " -f 4`
echo "$jid2: I will check the quality and generate statistics."

# Stripping primers and adapters		
jid3=`sbatch --dependency=afterok:$jid2 03_primerStrip-cutadapt.sb | cut -d" " -f 4`
echo "$jid6: I will remove primers and adapters with cutadapt. A subset of reads is generated for double checking." 

echo -e "\n========== Aligning ==========\n"
 
jid4=`sbatch --dependency=afterok:$jid3 04_AlignReads-hisat.sb | cut -d" " -f 4`
echo -e "$jid4: I will align reads to a reference."

jid5=`sbatch --dependency=afterok:$jid4 05_sort-samtools.sb | cut -d" " -f 4`
echo -e "$jid4: I will output only mapped reads and sort."


echo -e "\n========== Counting ==========\n" 

jid6=`sbatch --dependency=afterok:$jid5 06_count-htseq.sb | cut -d" " -f 4`
echo -e "$jid4: I will count number of reads in genes from a reference annotation."


echo -e "\n========== These below are the submitted sbatch... ==========\n" 
echo -e "\n `sq` \n"

echo -e "\n========== 'This is the end, my friend'... Now, be patient, you have to wait a bit... ==========\n"
