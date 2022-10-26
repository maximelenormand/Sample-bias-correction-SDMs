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

# Define function to compute the p-value
pval=function(X,Y){

  if(length(X)>0 & length(Y)>0){
    pval=tryCatch(rquery.t.test(X,Y,alternative="greater",graph=FALSE)$p.value, error=function(e){NA})
    res=pval
  }else{
    res=NA
  }

  return(res)

}

# Load projection table
proj=read.csv2(paste0("Data/Projections_", data,"_species.csv"), stringsAsFactors=FALSE)

# Initialize output 
spemod=aggregate(proj$Species, list(proj$Species, proj$Site, proj$Model, proj$Nb, proj$Sample), length)[,1:5]
spemod=spemod[order(spemod[,2],spemod[,1]),]
colnames(spemod)=c("Species","Site","Model","Nb Occ.","Sample Bias")

nspemod=dim(spemod)[1]

# Loop over species-model to compute the p-value (cor > uncor) for each metric
Boyce=NULL
cAUC=NULL
AUC=NULL
TSS=NULL
for(k in 1:nspemod){

  cor=proj[(proj$Species==spemod$Species[k] & proj$Site==spemod$Site[k] & proj$Model==spemod$Model[k] & proj$Group=="Corrected"),]       # Distribution of performance metric values for the corrected group 
  uncor=proj[(proj$Species==spemod$Species[k] & proj$Site==spemod$Site[k] & proj$Model==spemod$Model[k] & proj$Group=="Uncorrected"),]   # Distribution of performance metric values for the uncorrected group

  Boyce=c(Boyce,pval(cor$Boyce[!is.na(cor$Boyce)],uncor$Boyce[!is.na(uncor$Boyce)]))  # Compute p-value for the Boyce
  cAUC=c(cAUC,pval(cor$cAUC[!is.na(cor$cAUC)],uncor$cAUC[!is.na(uncor$cAUC)]))        # Compute p-value for the cAUC
  AUC=c(AUC,pval(cor$AUC[!is.na(cor$AUC)],uncor$AUC[!is.na(uncor$AUC)]))              # Compute p-value for the AUC
  TSS=c(TSS,pval(cor$TSS[!is.na(cor$TSS)],uncor$TSS[!is.na(uncor$TSS)]))              # Compute p-value for the TSS

}

spemod$Boyce_pvalue=Boyce
spemod$cAUC_pvalue=cAUC
spemod$AUC_pvalue=AUC
spemod$TSS_pvalue=TSS

# Export output
write.csv2(spemod, paste0("Data/Performance_", data,"_species.csv"), row.names=FALSE)








