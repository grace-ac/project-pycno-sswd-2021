notes:

[trasnferring raw data to owl from genefish](https://github.com/RobertsLab/resources/issues/1460)

[RNAseq workflow](https://github.com/RobertsLab/resources/issues/1476)

[RobertsLab data management](https://github.com/RobertsLab/resources/issues/1459) 

https://github.com/RobertsLab/resources/blob/master/docs/bio-Gene-expression.md

list of issues that I authored, some related to sea star RNAseq: https://github.com/RobertsLab/resources/issues?q=is%3Aissue+is%3Aclosed+author%3Agrace-ac 

https://www.genomesize.com/result_species.php?id=1584

https://www.ncbi.nlm.nih.gov/data-hub/taxonomy/7614/

---

Received data from Azenta (FKA Genewiz) 

# 1. Download all RNAseq and checksum files     
Downloaded to genefish using: [cyberduck](https://cyberduck.io/download/)     
Azenta provided log-in credentials of how to access their servers. 

All downloaded files were put into a folder on genefish called: "" 

Azenta (FKA Genewiz) pdf of different ways to download the data: [here](https://f.hubspotusercontent00.net/hubfs/3478602/Sell%20Sheet%20Collateral%20Library/NGS/NGS%20User%20Guides/NGS_sFTP-Data-Download-Guide_Option%201_Nov03_2020.pdf)
 
# 2. Move data to OWL        

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

#### B.2 Navigate to folder you want to work in, in my case: `owl/nightingales/P_Helianthoides`

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



