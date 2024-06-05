code for the different phases of RNAseq anaylses

# Phase I: Quality check and trimming        
A. [01-FastQC_pre-trim.Rmd](https://github.com/grace-ac/project_pycno/blob/main/code/01-FastQC_pre-trim.Rmd)      
B. Run `MulitQC` on the FASTQC output (notes on how: [protocols/RNAseq-pipeline.md](https://github.com/grace-ac/project_pycno/blob/main/protocols/RNAseq-pipeline.md))     
C. Trim Data

- [`11.0.0-trinity-denovo-unmapped-reads.Rmd`](https://github.com/grace-ac/project-pycno-sswd-2021/tree/main/code/11.0.0-trinity-denovo-unmapped-reads.Rmd): Trinity _de novo_ assembly of unmapped, HiSat2 reads, per [this GitHub Issue](https://github.com/RobertsLab/resources/issues/1915).

- [`12.0.0-blastn-unmapped-assembly.Rmd`](https://github.com/grace-ac/project-pycno-sswd-2021/tree/main/code/12.0.0-blastn-unmapped-assembly.Rmd): BLASTn against NCBI `nt` databse, with Trinity _de _novo_ assembly generated in [`11.0.0-trinity-denovo-unmapped-reads.Rmd`](https://github.com/grace-ac/project-pycno-sswd-2021/tree/main/code/11.0.0-trinity-denovo-unmapped-reads.Rmd).
