# Packages
library(DescTools)

# Working directory
#setwd()

# Load projection tables
projreal=read.csv2("Data/Projections_real_species.csv", stringsAsFactors=FALSE)         # Real species projection table
projvirtual=read.csv2("Data/Projections_virtual_species.csv", stringsAsFactors=FALSE)   # Virtual species projection table

# Table S1 (real species summary information)
spe=aggregate(projreal$Species, list(projreal$Species, projreal$Site, projreal$Nb, projreal$Sample), length)
spe=spe[order(spe[,2],spe[,1]),]

tex=paste0(spe[,1], " & ", spe[,2], " & ", spe[,3], " & ", round(spe[,4],digits=2), "\\")
print(data.frame(tex), row.names = FALSE)

# Table S2 (percentage of failed projections per real species and modelling technique for the uncorrected group)
bia=projreal[projreal$Group=="Uncorrected",c(1:3,14)]     
bia[,1]=paste0(bia[,1], " (",bia[,2],")")
bia=bia[,-2]

nbnabia=aggregate(is.na(bia$TSS), list(bia$Species, bia$Model), sum)
nbbia=aggregate(is.na(bia$TSS), list(bia$Species, bia$Model), length)
nabia=100*round(as.matrix.xtabs(xtabs(nbnabia[,3] ~ nbnabia[,1] + nbnabia[,2]))/as.matrix.xtabs(xtabs(nbbia[,3] ~ nbbia[,1] + nbbia[,2])),digit=2)

tex=paste0(rownames(nabia), " & ", nabia[,1], " & ", nabia[,2], " & ", nabia[,3], " & ", nabia[,4], " & ", nabia[,5], " & ", nabia[,6], " & ", nabia[,7], " & ", nabia[,8], "\\")
print(data.frame(tex), row.names = FALSE)

# Table S3 (percentage of failed projections per real species and modelling technique for the corrected group)
cor=projreal[projreal$Group=="Corrected",c(1:3,14)]
cor[,1]=paste0(cor[,1], " (",cor[,2],")")
cor=cor[,-2]

nbnacor=aggregate(is.na(cor$TSS), list(cor$Species, cor$Model), sum)
nbcor=aggregate(is.na(cor$TSS), list(cor$Species, cor$Model), length)
nacor=100*round(as.matrix.xtabs(xtabs(nbnacor[,3] ~ nbnacor[,1] + nbnacor[,2]))/as.matrix.xtabs(xtabs(nbcor[,3] ~ nbcor[,1] + nbcor[,2])),digit=2)

tex=paste0(rownames(nacor), " & ", nacor[,1], " & ", nacor[,2], " & ", nacor[,3], " & ", nacor[,4], " & ", nacor[,5], " & ", nacor[,6], " & ", nacor[,7], " & ", nacor[,8], "\\")
print(data.frame(tex), row.names = FALSE)

# Table S4 (virtual species summary information)
spe=aggregate(projvirtual$Species, list(projvirtual$Species, projvirtual$Site, projvirtual$Nb, projvirtual$Sample), length)
spe=spe[order(spe[,2],spe[,1]),]

tex=paste0(spe[,1], " & ", spe[,2], " & ", spe[,3], " & ", round(spe[,4],digits=2), "\\")
print(data.frame(tex), row.names = FALSE)

# Table S5 (percentage of failed projections per virtual species and modelling technique for the uncorrected group)
bia=projvirtual[projvirtual$Group=="Uncorrected",c(1:3,14)]     
bia[,1]=paste0(bia[,1], " (",bia[,2],")")
bia=bia[,-2]

nbnabia=aggregate(is.na(bia$TSS), list(bia$Species, bia$Model), sum)
nbbia=aggregate(is.na(bia$TSS), list(bia$Species, bia$Model), length)
nabia=100*round(as.matrix.xtabs(xtabs(nbnabia[,3] ~ nbnabia[,1] + nbnabia[,2]))/as.matrix.xtabs(xtabs(nbbia[,3] ~ nbbia[,1] + nbbia[,2])),digit=2)

tex=paste0(rownames(nabia), " & ", nabia[,1], " & ", nabia[,2], " & ", nabia[,3], " & ", nabia[,4], " & ", nabia[,5], " & ", nabia[,6], " & ", nabia[,7], " & ", nabia[,8], "\\")
print(data.frame(tex), row.names = FALSE)

# Table S6 (percentage of failed projections per virtual species and modelling technique for the corrected group)
cor=projvirtual[projvirtual$Group=="Corrected",c(1:3,14)]
cor[,1]=paste0(cor[,1], " (",cor[,2],")")
cor=cor[,-2]

nbnacor=aggregate(is.na(cor$TSS), list(cor$Species, cor$Model), sum)
nbcor=aggregate(is.na(cor$TSS), list(cor$Species, cor$Model), length)
nacor=100*round(as.matrix.xtabs(xtabs(nbnacor[,3] ~ nbnacor[,1] + nbnacor[,2]))/as.matrix.xtabs(xtabs(nbcor[,3] ~ nbcor[,1] + nbcor[,2])),digit=2)

tex=paste0(rownames(nacor), " & ", nacor[,1], " & ", nacor[,2], " & ", nacor[,3], " & ", nacor[,4], " & ", nacor[,5], " & ", nacor[,6], " & ", nacor[,7], " & ", nacor[,8], "\\")
print(data.frame(tex), row.names = FALSE)



