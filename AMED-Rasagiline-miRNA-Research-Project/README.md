# AMED Brain/MINDS Beyond Project
## Association Study of Symptomatic Efficacy of **Rasagiline** With Neurocircuits in Parkinson’s Disease

The aim of this study is to stratify Parkinson’s disease (PD) patient based on the consecutive, comprehensive, and multi-layered data with machine learning method.

![Figure](https://brainminds-beyond.jp/research/images/1_1hattori_en.png)

---

## The patient-derived data investigated in this research includes:

1. Cranial MRI, including tensor imaging
2. Plasma/serum metabolome, proteome
3. Serum exosomes miRNA transcriptome 

The data taken from patients with PD treated with/without **rasagiline**, a potential disease-modifying drug for PD (N Engl J Med 2009, Lancet Neurol 2011). 

These neuroimaging markers in a data-driven approach would enable us to stratify patients with Parkinson’s disease into distinct clusters, leading to establish novel therapeutic strategies.

---

### 2020 
- The *2020.xlsx* file contains the Reads Per Million Adjusted data of exosome miRNA profile from a cohort study including 50 PD VS 50 Control in Juntendo University obtained at 2022.

- The *2020.R* file performs DESeq2 analysis for the exosome miRNA profile.

---

### 2022-Rasagiline

- DESeq2  
  - The *2022_Rasagiline.xlsx* file contains the data of exosome miRNA profile generated from 46 patients before and after one-year rasagiline treatment
  - The *DESeq2.R* file performs DESeq2 analysis for the exosome miRNA profile
  - *PC1_loading.csv* contains the loading of PC1 axis
  - *PC2_loading.csv* contains the loading of PC2 axis
  - *Rasagiline_2022_Trimmed.csv* contains miRNAs that passed quality control process
  - *miRNA_Sig_De.csv* contains significangtly decreased miRNAs after rasagiline treatment
  - *miRNA_Sig_In.csv* contains significangtly increased miRNAs after rasagiline treatment

- In Silico Transcription factors  
  This folder contains information of transcription factors that regulate the expression of miRNAs using the **TransmiR** v2.0 database (Tong Z, Cui Q, Wang J, Zhou Y. TransmiR v2.0: an updated transcription factor-microRNA regulation database. Nucleic Acids Res. 2019 Jan 8;47(D1):D253-D258.)  
  [TransmiR](https://www.cuilab.cn/transmir)  

  The protein-protein association network of identified transcription factors is built with **STRING** V11(Szklarczyk, D. et al. STRING v11: protein-protein association networks with increased coverage, supporting functional discovery in genome-wide experimental datasets. Nucleic Acids Res 47, D607–D613 (2019))  
  [STRING](https://string-db.org/)  

  The pathway enrichment analysis is done with **ShinyGO** V0.77 (Ge, S. X., Jung, D. & Yao, R. ShinyGO: a graphical gene-set enrichment tool for animals and plants. Bioinformatics 36, 2628–2629 (2020)). All transcription factors from the TransmiR database are used as background genes.  
  [ShinyGO](http://bioinformatics.sdstate.edu/go/)

  -  *TF-Downregulated_miRNA.csv* contains transcription factors upstream of significantly downregulated miRNAs
  -  *TF-Upregulated_miRNA.csv/txt* contains transcription factors upstream of significantly downregulated miRNAs
  -  *STRING-Pathway.pdf* contains the results of STRING pathway analysis using ShinyGO
  -  *Visualization.R / TF.pdf* contains analysis and visualization of the results of identified TFs for significantly decreased miRNAs.

- miRNA GSEA  
  miRNA Gene Set Enrichment Analysis(GSEA) and Over-Representation Analysis are performed using the miEAA database(Kern, F. et al. miEAA 2.0: integrating multi-species microRNA enrichment analysis and workflow management systems. Nucleic Acids Res 48, W521–W528 (2020))  
  [miEAA](https://ccb-compute2.cs.uni-saarland.de/mieaa2/)
  - *results.csv* contains the rank of miRNAs  
    The rank is obtained using FC * abs(log(p))
  - *miEAA* contains the results of miRNA Gene Set Enrichment Analysis 

---
  
### 2022-MRI-Neuromelanin
- miRNA
  - *miRNA_FC_Calculation.R* contains the analysis for miRNA profiles at the 1st and 2nd visit, and the subsequent fold change
  - *Visit1_miRNA.csv, Visit2_miRNA.csv, FC_miRNA.csv* contains the data generated from the analysis

- Neuromelanin
  - *MRI-Neuromelanin.xlsx* contains the raw data of MRI neuromelanin data generated from patients before and after one-year rasagiline treatment
