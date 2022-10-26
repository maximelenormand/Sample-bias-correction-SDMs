# Packages
#remotes::install_github("leppott/ContDataQC")
library(ContDataQC)

# Option
options(scipen=10000)

# Working directory
#setwd()

# Real or virtual ?
data="real"
#data="virtual"

# Load projection and overlap tables
proj=read.csv2(paste0("Data/Projections_", data,"_species.csv"), stringsAsFactors=FALSE)
overlap=read.csv2(paste0("Data/Overlaps_", data,"_species.csv"), stringsAsFactors=FALSE)

# Compute the average overlaps between runs of the corrected groups for each species and model 
ovcorcor=overlap[overlap$Group1==overlap$Group2,]
ovcorcor=aggregate(ovcorcor[,10:12],list(ovcorcor$Species,ovcorcor$Site,ovcorcor$Model),mean)
colnames(ovcorcor)=c("Species","Site","Model","Schoener_Cor_Cor","Pearson_Cor_Cor","Spearman_Cor_Cor")

# Compute the average overlaps between corrected and uncorrected groups for each species and model 
ovuncorcor=overlap[overlap$Group1!=overlap$Group2,]
ovuncorcor=aggregate(ovuncorcor[,10:12],list(ovuncorcor$Species,ovuncorcor$Site,ovuncorcor$Model),mean)
colnames(ovuncorcor)=c("Species","Site","Model","Schoener_Uncor_Cor","Pearson_Uncor_Cor","Spearman_Uncor_Cor")

# Merge these two tables in a table "roi" (and add the bias and size)
ovuncorcor=ovuncorcor[match(paste0(ovcorcor$Species,"_",ovcorcor$Site,"_",ovcorcor$Model),paste0(ovuncorcor$Species,"_",ovuncorcor$Site,"_",ovuncorcor$Model)),]

size=proj[match(paste0(ovcorcor$Species,"_",ovcorcor$Site),paste0(proj$Species,"_",proj$Site)),7]
bias=proj[match(paste0(ovcorcor$Species,"_",ovcorcor$Site),paste0(proj$Species,"_",proj$Site)),8]

roi=data.frame(ovcorcor,ovuncorcor,bias,size)

sum(paste0(roi$Species,roi$Site,roi$Model)==paste0(roi$Species.1,roi$Site.1,roi$Model.1)) # Check that the merge is ok

roi=roi[,c(1,2,3,14,13,4,10,5,11,6,12)]
colnames(roi)[4:5]=c("Nb Occ.", "Sample Bias")

# Compute the ROI for each overlap metric
roi$ROI_Schoener=(roi$Schoener_Cor_Cor-roi$Schoener_Uncor_Cor)/roi$Schoener_Cor_Cor
roi$ROI_Pearson=(roi$Pearson_Cor_Cor-roi$Pearson_Uncor_Cor)/(1+roi$Pearson_Cor_Cor)
roi$ROI_Spearman=(roi$Spearman_Cor_Cor-roi$Spearman_Uncor_Cor)/(1+roi$Spearman_Cor_Cor)

# P-value for mean comparison (Schoener only)
pval=NULL
for(k in 1:dim(roi)[1]){

  ovcc=overlap[(overlap$Site==roi$Site[k] & overlap$Species==roi$Species[k] & overlap$Model==roi$Model[k] & overlap$Group1==overlap$Group2),]
  ovuc=overlap[(overlap$Site==roi$Site[k] & overlap$Species==roi$Species[k] & overlap$Model==roi$Model[k] & overlap$Group1!=overlap$Group2),]

  pval=c(pval,rquery.t.test(ovcc$Schoener, ovuc$Schoener, graph=FALSE, alternative="greater")$p.value)

}

roi$Schoener_pvalue=pval

# Export output
write.csv2(roi, paste0("Data/ROI_", data,"_species.csv"), row.names=FALSE)










