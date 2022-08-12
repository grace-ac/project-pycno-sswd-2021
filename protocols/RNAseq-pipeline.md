notes:

[trasnferring raw data to owl from genefish](https://github.com/RobertsLab/resources/issues/1460)

https://www.earthdatascience.org/courses/intro-to-earth-data-science/open-reproducible-science/bash/bash-commands-to-manage-directories-files/

[RNAseq workflow](https://github.com/RobertsLab/resources/issues/1476)

[RobertsLab data management](https://github.com/RobertsLab/resources/issues/1459)

https://github.com/RobertsLab/resources/blob/master/docs/bio-Gene-expression.md

list of issues that I authored, some related to sea star RNAseq: https://github.com/RobertsLab/resources/issues?q=is%3Aissue+is%3Aclosed+author%3Agrace-ac

https://www.genomesize.com/result_species.php?id=1584

https://www.ncbi.nlm.nih.gov/data-hub/taxonomy/7614/

FISH546-2021 syllabus: https://github.com/sr320/course-fish546-2021/wiki

---

# 1. Data Management

## Download all RNAseq and checksum files
Received data from Azenta (FKA Genewiz)

Downloaded to genefish using: [cyberduck](https://cyberduck.io/download/)     
Azenta provided log-in credentials of how to access their servers.

All downloaded files were put into a folder on genefish called: ""

Azenta (FKA Genewiz) pdf of different ways to download the data: [here](https://f.hubspotusercontent00.net/hubfs/3478602/Sell%20Sheet%20Collateral%20Library/NGS/NGS%20User%20Guides/NGS_sFTP-Data-Download-Guide_Option%201_Nov03_2020.pdf)

---

## Move data to OWL        

GitHub Issue: [#1460](https://github.com/RobertsLab/resources/issues/1460)

### A. `rsync` data to `owl/nightingales/P_helianthoides`


```
rsync --archive --progress --verbose PSC*.fastq.gz <owl username>@128.95.149.83:/volume1/web/nightingales/P_helianthoides/
```      
Replace <owl_username_> with whatever username you use to login to owl (even replace the < and the >).

### B. `rsync` checksums to OWL on commandine:    

#### B.1 `ssh` into owl:

```
ssh username@owl.fish.washington.edu
```

Will be prompted for password

#### B.2 Navigate to folder you want to work in, in my case: `owl/nightingales/P_helianthoides`

#### B.3 Put below code in and hit ENTER:
```
for fastq in PSC*.fastq.gz
do
  md5sum "${fastq}" >> checksums.md5
  echo "Generated checksum for ${file}."
  echo ""
done
```

All RNAseq data and checksums are now in [`owl/nightingales/P_Helianthoides`](http://owl.fish.washington.edu/nightingales/P_helianthoides/)     

---

# 2. Quality Check and Trimming

## 1. Untrimmed Data Quality Check Part I: FASTQC
### A. Get FastQC if you want to run on your laptop
https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc

### B. Get .fastq.gz files from OWL onto Raven
i. `ssh` into Raven using credentials in command line
ii. Make a directory for all PSC .fastq.gz files (made one called `pycnornaseq` in my `graceac9@raven`

```
graceac9@raven:~$ ls
examples.desktop  GitHub  R
graceac9@raven:~$ mkdir pycnornaseq
graceac9@raven:~$ ls
examples.desktop  GitHub  pycnornaseq  R
graceac9@raven:~$ cd pycnornaseq/
graceac9@raven:~/pycnornaseq$
```
<img width="573" alt="PSC_files_on_RAVEN" src="https://user-images.githubusercontent.com/14934314/182927133-a905bdf5-85f4-4b7d-8dcb-9e40579f9a98.png">



### C. Then move files from OWL to `pycnornaseq` directory in Raven:

a. Have Husky OnNet App (BIG-IP Edge Client in Applications folder after downloaded)        
b. Log in with UW credentials         
c. Put RStudio IP into browser: http://172.25.149.12:8787         
d. Log in using Raven Credentials         
e. `cd` into `pycnornaseq/` and run:        
```
wget -r --no-directories --no-parent  -A "PSC*" https://owl.fish.washington.edu/nightingales/P_helianthoides
```

### D. Get into RStudio on Raven to run FASTQC:
Follow the steps a-d in Step 3 above.

Then, follow the code outlined in this script: [scripts/01-FastQC_pre-trim.Rmd](https://github.com/grace-ac/project_pycno/blob/main/scripts/01-FastQC_pre-trim.Rmd)      

The FASTQC files are saved on Raven: `/home/shared/8TB_HDD_02/graceac9/analyses/pycno/`

---

## 2. Untrimmed Data Quality Check Part II: MultiQC
In the terminal of the same RSstudio project used in part C of section 3, run:     
```
eval "$(/opt/anaconda/anaconda3/bin/conda shell.bash hook)"
conda activate
```

Then navigate into the directory where the FASTQC output lives, in this case: graceac9@raven:~/analyses/pycno$, then run:    
```
multiqc .
```

The report will be generated in seconds to minutes.
<img width="1426" alt="pretrim-multiqc" src="https://user-images.githubusercontent.com/14934314/182927019-e671cc93-4d57-4627-9ab1-57eb8e772513.png">

<img width="1413" alt="Screen Shot 2022-08-04 at 11 36 09 AM" src="https://user-images.githubusercontent.com/14934314/182928170-293e7d28-44e4-448a-8226-3d2ba7d3c57e.png">

To view the report, transfer the .html report to Gannet or Owl, then you can view the .html report on your own browser.

I moved the untrimmed MultiQC report to Owl:
naviagate in terminal to directory where the .html report lives, then `rsync` file to where I want it on owl.  

```
graceac9@raven:~/analyses/pycno$ rsync --archive --progress --verbose multiqc_report.html grace@owl.fish.washington.edu:/volume1/web/scaphapoda/grace/pycno_2021/multiqc
grace@owl.fish.washington.edu's password:
sending incremental file list
multiqc_report.html
      1,853,263 100%   72.34MB/s    0:00:00 (xfr#1, to-chk=0/1)

sent 1,853,829 bytes  received 34 bytes  195,143.47 bytes/sec
total size is 1,853,263  speedup is 1.00
graceac9@raven:~/analyses/pycno$
```
REPORT: [pycno_2021/multiqc/multiqc_report.html](http://owl.fish.washington.edu/scaphapoda/grace/pycno_2021/multiqc/multiqc_report.html)

---

## 3. Trim RNAseq data: Run `fastp` on Mox, then `multiqc`          
### A. `rsync` RNAseq data (fastq.gz) from `nightingales` to `/gscratch/srlab/graceac9/data/pycno/RNAseq`        
i. navigate into `/nightingales/P_helianthoides` in command line on Owl       
ii. Copy in code: `rsync —archive —progress —verbose PSC*.fastq.gz  graceac9@mox.hyak.uw.edu:/gscratch/srlab/graceac9/data/pycno/RNAseq`         
iii. You'll be prompted for MOx password and then a second authentification, then you'll be good to go.     

Takes ~ 2 hours for 32 libraries. (started at ~12:51pm, ended 2:38pm)

### B. Add .sh script to my /gscratch/srlab/graceac9/jobs directory on Mox --> here's what I have based on [Sam's script](https://raw.githubusercontent.com/RobertsLab/sams-notebook/master/sbatch_scripts/20210714_cvir_gonad_RNAseq_fastp_trimming.sh): [code/02-20220809_pycno_fastp.sh](https://raw.githubusercontent.com/grace-ac/project_pycno/main/code/02-20220809_pycno_fastp.sh?token=GHSAT0AAAAAABWSNKWLMPAMQE4VEQ3JGB5IYXT5RBQ)     
i. navigate to `/gscratch/graceac9/jobs`, type `nano 20220810_pycno_fastp.sh`, then paste in code for 20220810_pycno_fastp.sh, and save. Typing `nano 20220810_pycno_fastp.sh` creates the .sh file and allows you to name it at the same time.

### C. Run the job. Navigate into `/gscratch/srlab/graceac9/jobs`, then run `sbatch 20220810_pycno_fastp.sh` and it will put output into `/gscratch/srlab/graceac9/analyses/pycno/20220810_PSC2021_trimming`  
job submitted at 17:35, 20220810         
Check job status by running: `squeue | grep "srlab"`          
Also, you should get an email at start time and end, as well as any errors occur.      
Run time: 2:21:56

The output will be that each library has 4 files:      
PSC-##_R1_001.fastq.gz.fastp-trim.20220810.fq.gz        
PSC-##_R1_001.fastq.gz.fastp-trim.20220810.report.html       
PSC-##_R1_001.fastq.gz.fastp-trim.20220810.report.json        
PSC-##_R2_001.fastq.gz.fastp-trim.20220810.fq.gz

Where `##` is the library number. Since they're paired end, the reports (report.html and report.json) contain info for both sets of reads (note from Sam White).

When I ran the `20220810_pycno_fastp.sh`, `multiqc` didn't run. Notes from Sam ([Issue #1476](https://github.com/RobertsLab/resources/issues/1476)):      

---

Looks like you don't have a default config file for MultiQC. Not sure why...

Anyway, you could copy mine to your home directory and re-run MultiQC:

Copy file to your home directory:

`cp /gscratch/srlab/sam/.multiqc_config.yaml ~`

Confirm copy command worked:

`ls ~/.multiqc_config.yaml`

Then, you can move to your working directory with all the trimming reports and run MultiQC:

`/gscratch/srlab/programs/anaconda3/bin/multiqc .`

---

NOTE: to get to home directory, while `ssh` in Mox, type `cd`, then `pwd`... mine is `/usr/lusers/graceac9`

My working directory with all the trimmed data is:    
`/gscratch/srlab/graceac9/analyses/pycno/20220810_PSC2021_trimming`

`multiqc` should run very fast.

### D. Move the multiqc report to OWL where the other one lives, but add the date and that it's for trimmed data.

Navigate in terminal to directory on Mox where the multiqc report lives

Then:
```
[graceac9@mox2 20220810_PSC2021_trimming]$ rsync --archive --progress --verbose multiqc_report.html grace@owl.fish.washington.edu:/volume1/web/scaphapoda/grace/pycno_2021/multiqc/trimmed
grace@owl.fish.washington.edu's password:
sending incremental file list
multiqc_report.html
      1,608,848 100%  375.77MB/s    0:00:00 (xfr#1, to-chk=0/1)

sent 1,609,360 bytes  received 34 bytes  153,275.62 bytes/sec
total size is 1,608,848  speedup is 1.00
[graceac9@mox2 20220810_PSC2021_trimming]$
```

REPORT for trimmed data: [scaphapoda/grace/pycno_2021/multiqc/trimmed/multiqc_report.html](http://owl.fish.washington.edu/scaphapoda/grace/pycno_2021/multiqc/trimmed/multiqc_report.html)

---

# 3. Assemble Transcriptome
There is no reference genome for _P. helianthoides_ (though one is in the works and may be published within this year...!). So, to continue with RNAseq analyses, a transcriptome must first be assembled.

First, [Trinity](https://github.com/trinityrnaseq/trinityrnaseq/wiki) will be used for assembly, then Transrate can be used for evaluating the assembly.

## 1. Use Trinity on Mox to Assemble Transcriptome
Use the trimmed data that was created in the previous section. Lives in:
`/gscratch/srlab/graceac9/analyses/pycno/20220810_PSC2021_trimming`, and the trimmed files end in `.fq.gz`

.sh script: [code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh](https://raw.githubusercontent.com/grace-ac/project_pycno/main/code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh?token=GHSAT0AAAAAABWSNKWK2K2D2CXVZIZOC7TYYXVTWRQ)

i. `ssh` into Mox and navigate to `/gscratch/srlab/graceac9/jobs`        
ii. Type `nano 20220811_pycno_trinity_RNAseq_transcriptome.sh` and copy code from [code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh](https://raw.githubusercontent.com/grace-ac/project_pycno/main/code/03-20220811_pycno_trinity_RNAseq_transcriptome.sh?token=GHSAT0AAAAAABWSNKWK2K2D2CXVZIZOC7TYYXVTWRQ) and save      
iii. Run script: `sbatch 20220811_pycno_trinity_RNAseq_transcriptome.sh`     
iv. Check status of job: `squeue | grep "srlab"`

Note: Submitted official job 20220812

# Note: Up In Arms paper has a published transcriptome from taht study. So... while this new transcriptome is assembling, I'll move forward to psuedoalignment of the new libraries to the old transcriptome using `kallisto`.

---

# 4. Pseudoalign New RNAseq data to Up in Arms transcriptome using `kallisto`

Run `kallisto` on Raven, based on this notebook: [notebooks/kallisto-4libraries.ipynb](https://github.com/RobertsLab/paper-tanner-crab/blob/master/notebooks/kallisto-4libraries.ipynb) from crab paper
