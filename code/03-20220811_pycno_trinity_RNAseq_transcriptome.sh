#!/bin/bash
## Job Name
#SBATCH --job-name=20220811_pycno_trinity_RNAseq_transcripome
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=10-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=graceac9@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/srlab/graceac9/analyses/pycno/20220811_trinity_out

# Load Python Mox module for Python module availability

module load intel-python3_2017


data_dir=/gscratch/srlab/graceac9/analyses/pycno/20220810_PSC2021_trimming
trinity_dir=/gscratch/srlab/programs/Trinity-v2.8.3
assembly_stats=assembly_stats.txt

# Custom PATH

export PATH="$PATH:\
/gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64:\
/gscratch/srlab/programs/anaconda3/bin/cutadapt:\
/gscratch/srlab/programs/FastQC:\
/gscratch/srlab/programs/jellyfish-2.2.10/bin:\
/gscratch/srlab/programs/salmon-0.11.2-linux_x86_64/bin:\
/gscratch/srlab/programs/samtools-1.9"

# Run Trinity
${trinity_dir}/Trinity \
--seqType fq \
--max_memory 100G \
--left ${data_dir}/PSC-19_R1_001.fastq.gz.fastp-trim.20220810.fq.gz,\
${data_dir}/PSC-23_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-24_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-34_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-35_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-36_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-37_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-38_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-39_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-40_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-42_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-43_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-48_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-49_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-52_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-54_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-56_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-57_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-58_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-59_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-61_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-63_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-64_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-67_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-69_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-71_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-73_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-75_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-76_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-78_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-81_R1_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-83_R1_001.fastq.gz.fastp-trim.20220810.fq.gz \
--right ${data_dir}/PSC-19_R2_001.fastq.gz.fastp-trim.20220810.fq.gz,\
${data_dir}/PSC-23_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-24_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-34_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-35_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-36_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-37_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-38_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-39_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-40_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-42_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-43_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-48_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-49_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-52_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-54_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-56_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-57_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-58_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-59_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-61_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-63_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-64_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-67_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-69_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-71_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-73_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-75_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-76_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-78_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-81_R2_001.fastq.gz.fastp-trim.20220810.fq.gz, \
${data_dir}/PSC-83_R2_001.fastq.gz.fastp-trim.20220810.fq.gz \
--CPU 28

# Assembly stats
${trinity_dir}/util/TrinityStats.pl trinity_out_dir/Trinity.fasta \
> ${assembly_stats}

# Create gene map files
${trinity_dir}/util/support_scripts/get_Trinity_gene_to_trans_map.pl \
trinity_out_dir/Trinity.fasta \
> trinity_out_dir/Trinity.fasta.gene_trans_map

# Create sequence lengths file (used for differential gene expression)
${trinity_dir}/util/misc/fasta_seq_length.pl \
trinity_out_dir/Trinity.fasta \
> trinity_out_dir/Trinity.fasta.seq_lens

# Create FastA index
${programs_array[samtools_faidx]} \
trinity_out_dir/Trinity.fasta
