#!/bin/bash
## Job Name
#SBATCH --job-name=gac_2021_hisat2
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=2-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=graceac9@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/srlab/graceac9/jobs/

#Code modified from A. Huffmeyer: https://github.com/AHuffmyer/EarlyLifeHistory_Energetics/blob/master/Mcap2020/Scripts/TagSeq/TagSeq_BioInf.md

#Exit script if any command fails
set -e

#Load modules needed
module load bio
module load samtools/1.12

#Set variable paths
data_dir="/gscratch/scrubbed/graceac9/ncbi_dataset/data/GCA_032158295.1"
hisat2_dir="/gscratch/srlab/programs/hisat2-2.2.0"
reads_dir="/gscratch/srlab/graceac9/analyses/pycno/20220810_PSC2021_trimming"

#Index the reference genome for P. helianthoides
${hisat2_dir}/hisat2-build -f ${data_dir}/GCA_032158295.1_ASM3215829v1_genomic.fna ${data_dir}/Phelianthoides_ref # called the reference genome (scaffolds)
echo "Reference genome indexed. Starting alignment" $(date)

#Make an array of trimmed sequences
array=($(ls ${reads_dir}/*fq.gz))

#For each sample in the array
#Isolate the sample name
#Specify the file for alignment (-U)
#Specify number of threads (-p)
#Align to the indexed genome (-x)
#Report alignments tailed for transcript assembles (--dta)
#File for output SAM alignments (-S)
#Sort SAM and convert to BAM the bam file because Stringtie takes a sorted file for input
#Delete SAM file
for i in ${array[@]}
  do
    sample_name=`echo $i | awk -F [.] '{print $2}' | awk -F [/] '{print $6}' | sed 's/_trimmed_trimmed_trimmed//'`
    ${hisat2_dir}/hisat2 -p 8 --dta -x ${data_dir}/Phelianthoides_ref -U ${i} -S ${sample_name}.sam
        samtools sort -@ 8 -o ${sample_name}.bam ${sample_name}.sam
    		echo "${i} bam-ified!"
        rm ${sample_name}.sam
done
