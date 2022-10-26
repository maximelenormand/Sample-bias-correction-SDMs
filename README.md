Assessing the effect of sample bias correction in species distribution models
========================================================================

## Description

This repository contains all the material (code and aggregated data) needed to perform the analysis and produce the tables and figures that can be found in [1]. This paper assesses the extent to which an acknowledged sample bias correction technique is likely to improve the ability of Species Distribution Models (SDMs) to predict species distributions in the absence of independent data.

The repository is composed of two folders: the folder **Data** containing the SDMs' outputs and the folder **Scripts** containing four R scripts used to process the data and extract some metrics (**ROI.R** and **Performance.R**) and to produce the different figures that can be found in the manuscript is Supporting Information (**Figures.R**) and the tables that can be found in the Supporting Information (**Tables_SI.R**).

## Data

Two projection tables for both real and virtual species (**Projections_real_species** and **Projections_virtual_species**).
 
- **Species:** Species name (64 real species or 21 virtual species)      
- **Site:** Case study site (Grote Nete, Thau and Trondheim)
- **Model:** Modelling technique (ANN, CTA, FDA, GAM, GBM, GLM, RF and SRE)       
- **CV:** Cross-validation run (RUN1->RUN3)          
- **PA:** Pseudo Absence run (PA1->PA10)       
- **Group:** Correction technique (Corrected=weighted by AI and Uncorrected=random)       
- **Nb Occ.:** Number of occurences per species (after thinning/resampling)     
- **Sample Bias:** Sample bias per species (estimated with the Boyce index)
- **Jaccard:** Similarity in selected variables between the uncorrected and the corrected groups (at species level) 
- **Bray-Curtis:** Similarity in variables importance between the uncorrected and the corrected groups (at species level)  
- **Boyce:** Boyce index (performance evaluation metric)
- **cAUC:** Area Under Curve (performance evaluation metric)
- **AUC:** corrected Area Under Curve (performance evaluation metric)
- **TSS:** True Skill Statistic (performance evaluation metric)

Two overlap tables for both real and virtual species (**Overlaps_real_species** and **Overlaps_virtual_species**).     
- **Species:** Species name (64 real species or 21 virtual species)      
- **Site:** Case study site (Grote Nete, Thau and Trondheim)
- **Model:** Modelling technique (ANN, CTA, FDA, GAM, GBM, GLM, RF and SRE)          
- **Group1:** Correction technique (associated with the first element of pairwise comparison) 
- **CV1:** Cross-validation run (associated with the first element of pairwise comparison)        
- **PA1:** Pseudo Absence run (associated with the first element of pairwise comparison) 
- **Group2:** Correction technique (associated with the second element of pairwise comparison) 
- **CV2:** Cross-validation run (associated with the second element of pairwise comparison)             
- **PA2:** Pseudo Absence run (associated with the second element of pairwise comparison) 
- **Schoener:** Schoener's D overlap between projections
- **Pearson:** Pearson's correlation coefficient between projections  
- **Spearman:** Spearman's rank coefficient between projections

One 'true' overlap table only for virtual species (**Overlaps_true_virtual_species**)

- **Species:** Species name (21 virtual species)      
- **Site:** Case study site (Grote Nete, Thau and Trondheim)
- **Model:** Modelling technique (ANN, CTA, FDA, GAM, GBM, GLM, RF and SRE)            
- **Schoener_Cor:** Schoener's D overlap between corrected and 'true' distribution 
- **Schoener_Uncor:** Schoener's D overlap between uncorrected and 'true' distribution   
- **Schoener_pvalue:** One-sided Student t-test between Schoener's D overlaps (corrected greater than uncorrected)
- **Pearson_Cor:** Pearson's correlation coefficient between corrected and 'true' distribution 
- **Pearson_Uncor:** Pearson's correlation coefficient between uncorrected and 'true' distribution       
- **Pearson_pvalue:** One-sided Student t-test between Pearson's correlation coefficient (corrected greater than uncorrected)
- **RMSE_Cor:** Root-mean-square-error between corrected and 'true' distribution 
- **RMSE_Uncor:** Root-mean-square-error between uncorrected and 'true' distribution           
- **RMSE_pvalue:** One-sided Student t-test between RMSE (uncorrected greater than corrected)

Two ROI's tables generated with the script **ROI.R** (see below) for both real and virtual species (**ROI_real_species** and **ROI_virtual_species**).

- **Species:** Species name (64 real species or 21 virtual species)      
- **Site:** Case study site (Grote Nete, Thau and Trondheim)
- **Model:** Modelling technique (ANN, CTA, FDA, GAM, GBM, GLM, RF and SRE)            
- **Nb Occ.:** Number of occurences per species (after thinning/resampling)     
- **Sample Bias:** Sample bias per species (estimated with the Boyce index)
- **Schoener_Cor_Cor:** Average Schoener'D overlap between pairwise model projections of the corrected group        
- **Schoener_Uncor_Cor:** Average Schoener'D overlap between projections of the corrected and uncorrected groups
- **Pearson_Cor_Cor:** Average Pearson's correlation coefficient between pairwise model projections of the corrected group
- **Pearson_Uncor_Cor:** Average Pearson's correlation coefficient between projections of the corrected and uncorrected groups       
- **Spearman_Cor_Cor:** Average Spearman's rank coefficient between pairwise model projections of the corrected group
- **Spearman_Uncor_Cor:** Average Spearman's rank coefficient between projections of the corrected and uncorrected groups
- **ROI_Schoener:** Relative Overlap Index based on the Schoener'D overlap    
- **ROI_Pearson:** Relative Overlap Index based on the Pearson's correlation coefficient
- **ROI_Spearman:** Relative Overlap Index based on the Spearman's rank coefficient
- **Schoener_pvalue:** One-sided Student t-test between Schoener's D overlaps (corrected-corrected greater than corrected-uncorrected)

Two performance's tables generated with the script **Performance.R** (see below) for both real and virtual species (**Performance_real_species** and **Performance_virtual_species**).

- **Species:** Species name (64 real species or 21 virtual species)      
- **Site:** Case study site (Grote Nete, Thau and Trondheim)
- **Model:** Modelling technique (ANN, CTA, FDA, GAM, GBM, GLM, RF and SRE)            
- **Nb Occ.:** Number of occurences per species (after thinning/resampling)     
- **Sample Bias:** Sample bias per species (estimated with the Boyce index)
- **Boyce_pvalue:** One-sided Student t-test between corrected and uncorrected Boyce (mean corrected performance is significantly greater than the mean uncorrected performance)       
- **cAUC_pvalue:** One-sided Student t-test between corrected and uncorrected cAUC (mean corrected performance is significantly greater than the mean uncorrected performance)  
- **AUC_pvalue:** One-sided Student t-test between corrected and uncorrected AUC (mean corrected performance is significantly greater than the mean uncorrected performance)  
- **TSS_pvalue:** One-sided Student t-test between corrected and uncorrected TSS (mean corrected performance is significantly greater than the mean uncorrected performance)  
  
All the files are in csv format with column names and no row names (the value separator is a semicolon ";").
  
## Scripts

- **ROI.R** is used to generate the ROI's real (or virtual) table (see above) based on the real (or virtual) projection and overlap tables
- **Performance.R** is used to generate the performance's real (or virtual) table (see above) based on the real (or virtual) projection table
- **Figures.R** is used to produce the figures of the manuscript (Figure 2 and Figures 4->8) and the Supporting Information (Figures S24->S29) 
- **Tables_SI.R** is used to produce the tables of Supporting Information (Tables S1->S6)

## Contributors

- [Maxime Lenormand](https://www.maximelenormand.com/)
- [Nicolas Dubos](https://scholar.google.fr/citations?user=R7md47gAAAAJ&hl=fr)

## Reference

[1] Dubos *et al.* (2022) [Assessing the effect of sample bias correction in species distribution models](https://www.sciencedirect.com/science/article/pii/S1470160X22009608). *Ecological Indicators* 145, 109487.   

## Citation

If you use this code, please cite:

Dubos *et al.* (2022) [Assessing the effect of sample bias correction in species distribution models](https://www.sciencedirect.com/science/article/pii/S1470160X22009608). *Ecological Indicators* 145, 109487.   

If you need help, find a bug, want to give me advice or feedback, please contact me!
You can reach me at maxime.lenormand[at]inrae.fr
