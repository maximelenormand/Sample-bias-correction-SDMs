# Packages
library(TeachingDemos)
library(scales)
library(DescTools)
library(RColorBrewer) 

# Working directory
#setwd()

# Load tables
projr=read.csv2("Data/Projections_real_species.csv", stringsAsFactors=FALSE)         # Real species projection table
roir=read.csv2("Data/ROI_real_species.csv", stringsAsFactors=FALSE)                  # Real species roi table (based on the overlap table - see script ROI.R)
perfr=read.csv2("Data/Performance_real_species.csv", stringsAsFactors=FALSE)         # Real species performance table (based on the projection table - see script Performance.R)

projv=read.csv2("Data/Projections_virtual_species.csv", stringsAsFactors=FALSE)      # Virtual species projection table
roiv=read.csv2("Data/ROI_virtual_species.csv", stringsAsFactors=FALSE)               # Virtual species roi table (based on the overlap table - see script ROI.R)
perfv=read.csv2("Data/Performance_virtual_species.csv", stringsAsFactors=FALSE)      # Virtual species performance table (based on the projection table - see script Performance.R)
ovtrue=read.csv2("Data/Overlaps_true_virtual_species.csv", stringsAsFactors=FALSE)   # Virtual species "true" overlap table 

# Real species summary information
spe=aggregate(projr$Species, list(projr$Species, projr$Site, projr$Nb.Occ, projr$Sample, projr$Jaccard, projr$Bray.Curtis), length)[,1:6]
colnames(spe)=c("Species","Site","Size","Bias","Jaccard","Bray")

# Figure 2
colo=c("#F8766D","#32CD32","#5F9DFB")  # Define color

box=list()
box[[1]]=spe$Bias[spe$Site=="Grote Nete"]   # Sample bias in Grote Nete
box[[2]]=spe$Bias[spe$Site=="Thau"]         # Sample bias in Thau
box[[3]]=spe$Bias[spe$Site=="Trondheim"]    # Sample bias in Trondheim

b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}

pdf("Fig2.pdf", width=7.8, height=7, useDingbats=FALSE)
   par(mar=c(6,6,1,1))     
   bxp(b,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(-1,1))
   axis(1, at=c(1,2,3), labels=c("Grote Nete","Thau","Trondheim"), las=1, cex.axis=1.5, padj=-0.3, tick=FALSE)
   axis(2, las=1, cex.axis=1.5)
   mtext("Case Study Site", 1, line=4, cex=2)
   mtext("Sample Bias (Boyce)", 2, line=4.25, cex=2)
dev.off()

mean(box[[1]]) # Average sample bias in Grote Nete
mean(box[[2]]) # Average sample bias in Thau
mean(box[[3]]) # Average sample bias in Trondheim


# Figure 4
box=list()  # a
box[[1]]=roir$Schoener_Uncor_Cor[roir$Site=="Grote Nete"]  # Overlap between corrected and uncorrected in Grote Nete (Schoener)
box[[2]]=roir$Schoener_Uncor_Cor[roir$Site=="Thau"]        # Overlap between corrected and uncorrected in Thau (Schoener)
box[[3]]=roir$Schoener_Uncor_Cor[roir$Site=="Trondheim"]   # Overlap between corrected and uncorrected in Trondheim (Schoener)
box[[4]]=roir$Pearson_Uncor_Cor[roir$Site=="Grote Nete"]   # Overlap between corrected and uncorrected in Grote Nete (Pearson)
box[[5]]=roir$Pearson_Uncor_Cor[roir$Site=="Thau"]         # Overlap between corrected and uncorrected in Thau (Pearson)
box[[6]]=roir$Pearson_Uncor_Cor[roir$Site=="Trondheim"]    # Overlap between corrected and uncorrected in Trondheim (Pearson)
box[[7]]=roir$Spearman_Uncor_Cor[roir$Site=="Grote Nete"]  # Overlap between corrected and uncorrected in Grote Nete (Spearman)
box[[8]]=roir$Spearman_Uncor_Cor[roir$Site=="Thau"]        # Overlap between corrected and uncorrected in Thau (Spearman)
box[[9]]=roir$Spearman_Uncor_Cor[roir$Site=="Trondheim"]   # Overlap between corrected and uncorrected in Trondheim (Spearman)
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
ba=b

box=list()  # b
box[[1]]=spe$Jaccard[spe$Site=="Grote Nete"] # Variable overlap between corrected and uncorrected in Grote Nete (Jaccard)             
box[[2]]=spe$Jaccard[spe$Site=="Thau"]       # Variable overlap between corrected and uncorrected in Thau (Jaccard)
box[[3]]=spe$Jaccard[spe$Site=="Trondheim"]  # Variable overlap between corrected and uncorrected in Trondheim (Jaccard)
box[[4]]=spe$Bray[spe$Site=="Grote Nete"]    # Variable overlap between corrected and uncorrected in Grote Nete (Bray-Curtis) 
box[[5]]=spe$Bray[spe$Site=="Thau"]          # Variable overlap between corrected and uncorrected in Thau (Bray-Curtis)
box[[6]]=spe$Bray[spe$Site=="Trondheim"]     # Variable overlap between corrected and uncorrected in Trondheim (Bray-Curtis)
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
bb=b

box=list()  # c
box[[1]]=perfr$Boyce_pvalue[perfr$Site=="Grote Nete"]  # P-value for performance comparison between corrected and uncorrected in Grote Nete (Boyce)
box[[2]]=perfr$Boyce_pvalue[perfr$Site=="Thau"]        # P-value for performance comparison between corrected and uncorrected in Thau (Boyce)
box[[3]]=perfr$Boyce_pvalue[perfr$Site=="Trondheim"]   # P-value for performance comparison between corrected and uncorrected in Trondheim (Boyce)
box[[4]]=perfr$cAUC_pvalue[perfr$Site=="Grote Nete"]   # P-value for performance comparison between corrected and uncorrected in Grote Nete (cAUC)
box[[5]]=perfr$cAUC_pvalue[perfr$Site=="Thau"]         # P-value for performance comparison between corrected and uncorrected in Thau (cAUC)
box[[6]]=perfr$cAUC_pvalue[perfr$Site=="Trondheim"]    # P-value for performance comparison between corrected and uncorrected in Trondheim (cAUC)
box[[7]]=perfr$AUC_pvalue[perfr$Site=="Grote Nete"]    # P-value for performance comparison between corrected and uncorrected in Grote Nete (AUC)
box[[8]]=perfr$AUC_pvalue[perfr$Site=="Thau"]          # P-value for performance comparison between corrected and uncorrected in Thau (AUC)
box[[9]]=perfr$AUC_pvalue[perfr$Site=="Trondheim"]     # P-value for performance comparison between corrected and uncorrected in Trondheim (AUC)
box[[10]]=perfr$TSS_pvalue[perfr$Site=="Grote Nete"]   # P-value for performance comparison between corrected and uncorrected in Grote Nete (TSS)
box[[11]]=perfr$TSS_pvalue[perfr$Site=="Thau"]         # P-value for performance comparison between corrected and uncorrected in Thau (TSS)
box[[12]]=perfr$TSS_pvalue[perfr$Site=="Trondheim"]    # P-value for performance comparison between corrected and uncorrected in Trondheim (TSS)
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
bc=b

pdf("Fig4.pdf", width=18.885417, height=6.347878, useDingbats=FALSE)

   layout(matrix(c(1,2,3,4,4,4), 2, 3, byrow=TRUE),width=c(1,1,1),height=c(1,0.1))

   # a
   par(mar=c(5,7,2,1))    
bxp(ba,notch=TRUE,at=c(1:3,5:7,9:11),outline=FALSE,boxcol=rep(colo,3),whiskcol=rep(colo,3),whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.75,staplecol=rep(colo,3),medbg=rep(colo,3),boxfill=rep(colo,3),cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
   axis(1, at=c(2,6,10), labels=c("Schoener","Pearson","Spearman"), las=1, cex.axis=1.75, padj=-1, tick=FALSE,font=2)
   axis(2, las=1, cex.axis=1.75)
   mtext("Projection overlap measures", 1, line=3.5, cex=1.75)
   mtext("Overlap", 2, line=4.5, cex=1.75)
   legend("topleft",inset=c(-0.28,-0.1),legend="(a)",bty="n",cex=3,xpd=TRUE,text.font=2)

   # b
      par(mar=c(5,7,2,1))    
bxp(bb,at=c(1:3,5:7),outline=FALSE,boxcol=rep(colo,2),whiskcol=rep(colo,2),whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.75,staplecol=rep(colo,2),medbg=rep(colo,2),boxfill=rep(colo,2),cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
   axis(1, at=c(2,6), labels=c("Jaccard","Bray-Curtis"), las=1, cex.axis=1.75, padj=-1, tick=FALSE,font=2)
   axis(2, las=1, cex.axis=1.75)
   mtext("Variable similarity measures", 1, line=3.5, cex=1.75)
   mtext("Similarity", 2, line=4.5, cex=1.75)
   legend("topleft",inset=c(-0.28,-0.1),legend="(b)",bty="n",cex=3,xpd=TRUE,text.font=2)

   # c
   par(mar=c(5,7,2,1))    
bxp(bc,at=c(1:3,5:7,9:11,13:15),outline=FALSE,boxcol=rep(colo,4),whiskcol=rep(colo,4),whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.75,staplecol=rep(colo,4),medbg=rep(colo,4),boxfill=rep(colo,4),cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
   axis(1, at=c(2,6,10,14), labels=c("Boyce","cAUC","AUC","TSS"), las=1, cex.axis=1.75, padj=-1, tick=FALSE,font=2)
   axis(2, at=seq(0,1,0.2), las=1, cex.axis=1.75)
   mtext("Performance metrics", 1, line=3.5, cex=1.75)
   mtext("p-value", 2, line=4.5, cex=1.75)
   legend("topleft",inset=c(-0.28,-0.1),legend="(c)",bty="n",cex=3,xpd=TRUE,text.font=2)

   abline(h=0.05, col="grey", lwd=3)

   # Legend 
   par(mar=c(0,0,0,0))
   plot(1,type="n",axes=FALSE,xlab="",ylab="")
   legend("bottom",inset=c(0,-0.1) , fill=colo, border=colo, legend=c("Grote Nete","Thau","Trondheim"), cex=2.5, bty="n", xpd=NA, text.font=2, horiz=TRUE, text.width=2*strwidth(c("Grote Nete","Thau","Trondheim")))

dev.off()


# Figure 5
box=list()  
box[[1]]=roir$ROI_Schoener[roir$Site=="Grote Nete"] # ROI in Grote Nete (Schoner)
box[[2]]=roir$ROI_Schoener[roir$Site=="Thau"]       # ROI in Thau (Schoner)
box[[3]]=roir$ROI_Schoener[roir$Site=="Trondheim"]  # ROI in Trondheim (Schoner)
b=boxplot(box, plot=F)
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}

pdf("Fig5.pdf", width=11.875000, height=8.986767, useDingbats=FALSE)

   # Scatterplots between overlaps (Do in x-axis and D in y-axis)
   par(mar=c(6.5,7,1,15))  
   plot(roir$Schoener_Cor_Cor[roir$Site=="Trondheim"], roir$Schoener_Uncor_Cor[roir$Site=="Trondheim"], pch=16, col=colo[3], cex=1.5, xlim=c(0.2,1), ylim=c(0.2,1), xlab="", ylab="", axes=FALSE)
   par(new=TRUE)
   plot(roir$Schoener_Cor_Cor[roir$Site=="Grote Nete"], roir$Schoener_Uncor_Cor[roir$Site=="Grote Nete"], pch=16, col=colo[1], cex=1.5, xlim=c(0.2,1), ylim=c(0.2,1), xlab="", ylab="", axes=FALSE)
   par(new=TRUE)
   plot(roir$Schoener_Cor_Cor[roir$Site=="Thau"], roir$Schoener_Uncor_Cor[roir$Site=="Thau"], pch=16, col=colo[2], cex=1.5, xlim=c(0.2,1), ylim=c(0.2,1), xlab="", ylab="", axes=FALSE)

   axis(1, las=1, cex.axis=1.75)
   axis(2, las=1, cex.axis=1.75)
   mtext("Overlap between runs", 1, line=4, cex=2)
   mtext("Overlap between uncorrected and corrected", 2, line=4.5, cex=2)
   box(lwd=1.5)

   abline(0,1,lwd=4,col="grey",lty=2)

   legend("right",inset=c(-0.36,0) , fill=colo, border=colo, legend=c("Grote Nete","Thau","Trondheim"), cex=1.8, bty="n", xpd=NA,text.font=2)

   # ROI in inset
   subplot(fun={

   par(mar=c(6,6,1,1))      
bxp(b,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,0.3))
   axis(2, las=1, cex.axis=1.5)
   mtext("ROI (Schoener)", 2, line=4.25, cex=2)

   abline(h=0.02, col="grey", lwd=3)

           }, x=grconvertX(c(0.03,0.58), from='npc'),y=grconvertY(c(0.45,0.98), from='npc'),type='fig', pars=list( mar=c(0,5,0,0)))

dev.off()


# Figure 6
ovtruebis=ovtrue[match(paste0(roiv[,1],"_",roiv[,2],"_",roiv[,3]),paste0(ovtrue[,1],"_",ovtrue[,2],"_",ovtrue[,3])),] # Virtual species "true" overlap table that matches with roiv
perfvbis=perfv[match(paste0(roiv[,1],"_",roiv[,2],"_",roiv[,3]),paste0(perfv[,1],"_",perfv[,2],"_",perfv[,3])),]      # Virtual species performance table that matches with roiv

print(c(sum(paste0(roiv[,1],"_",roiv[,2],"_",roiv[,3])==paste0(ovtruebis[,1],"_",ovtruebis[,2],"_",ovtruebis[,3])),sum(paste0(roiv[,1],"_",roiv[,2],"_",roiv[,3])==paste0(perfvbis[,1],"_",perfvbis[,2],"_",perfvbis[,3])))) # Check matches


vpvaltrue=ovtruebis$Schoener_pvalue # Schoener p-value (true distribution)
vpvalboyce=perfvbis$Boyce_pvalue    # Boyce p-value (performance)
vpvalcauc=perfvbis$cAUC_pvalue      # cAUC p-value (performance)
vpvalauc=perfvbis$AUC_pvalue        # AUC p-value (performance)
vpvaltss=perfvbis$TSS_pvalue        # TSS p-value (performance)
vpvalroi=roiv$Schoener_pvalue       # Schoener p-value (overlap corrected/uncorrected versus overlap corrected between runs)

pall=NULL
for(th in seq(0.01,0.1,0.01)){ # Loop over different thershold to compute the accuracy (fraction of TP and TN)

  pth=th

  conf=table(vpvaltrue<th,vpvalroi<th)
  p=sum(diag(conf))/sum(conf)  
  if(th==0.05){
    print(conf)
  }

  pth=c(pth,p)

  conf=table(vpvaltrue<th,vpvalboyce<th)
  p=sum(diag(conf))/sum(conf)
  if(th==0.05){
    print(conf)
  }

  pth=c(pth,p)

  conf=table(vpvaltrue<th,vpvalcauc<th)
  p=sum(diag(conf))/sum(conf)
  if(th==0.05){
    print(conf)
  }

  pth=c(pth,p)

  conf=table(vpvaltrue<th,vpvalauc<th)
  p=sum(diag(conf))/sum(conf)
  if(th==0.05){
    print(conf)
  }

  pth=c(pth,p)

  conf=table(vpvaltrue<th,vpvaltss<th)
  p=sum(diag(conf))/sum(conf)
  if(th==0.05){
    print(conf)
  }

  pth=c(pth,p)

  pall=rbind(pall,pth)

}

box=NULL
box[[1]]=ovtrue$Schoener_pvalue[ovtrue$Site=="Grote Nete"] # Schoener p-value (true distribution) in Grote Nete
box[[2]]=ovtrue$Schoener_pvalue[ovtrue$Site=="Thau"]       # Schoener p-value (true distribution) in Thau
box[[3]]=ovtrue$Schoener_pvalue[ovtrue$Site=="Trondheim"]  # Schoener p-value (true distribution) in Trondheim
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}

pdf("Fig6.pdf", width=16.760417, height=7.054353, useDingbats=FALSE)

  par(mfrow=c(1,2))

  # a
  par(mar=c(4.5,6.5,1.5,1))   
  bxp(b,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
  axis(1, at=c(1,2,3), labels=c("Grote Nete","Thau","Trondheim"), las=1, cex.axis=1.5, padj=-0.5, tick=FALSE)
  axis(2, las=1, cex.axis=1.5)
  mtext("Case Study Site", 1, line=3, cex=2)
  mtext("p-value (Schoener)", 2, line=4.25, cex=2)
  legend("topleft",inset=c(-0.295,-0.1),legend="(a)",bty="n",cex=2.5,xpd=TRUE,text.font=2)
  abline(h=0.05, col="grey", lwd=3)

  # b
  coll=brewer.pal(5, "Set2")

  par(mar=c(4.5,6.5,1.5,1)) 
  plot(pall[,c(1,2)], type="l", col=coll[1], lty=1, lwd=4, ylim=c(0.3,0.7),axes=FALSE,xlab="",ylab="")
  par(new=TRUE)
  plot(pall[,c(1,3)], type="l", col=coll[2], lty=2, lwd=4, ylim=c(0.3,0.7),axes=FALSE,xlab="",ylab="")
  par(new=TRUE)
  plot(pall[,c(1,4)], type="l", col=coll[3], lty=3, lwd=4, ylim=c(0.3,0.7),axes=FALSE,xlab="",ylab="")
  par(new=TRUE)
  plot(pall[,c(1,5)], type="l", col=coll[4], lty=4, lwd=4, ylim=c(0.3,0.7),axes=FALSE,xlab="",ylab="")
  par(new=TRUE)
  plot(pall[,c(1,6)], type="l", col=coll[5], lty=5, lwd=4, ylim=c(0.3,0.7),axes=FALSE,xlab="",ylab="")
  axis(1, las=1, cex.axis=1.5)
  axis(2, las=1, cex.axis=1.5)
  mtext("p-value threshold", 1, line=3, cex=2)
  mtext("Accuracy", 2, line=4.25, cex=2)
  box(lwd=1.5)
  legend("topleft",inset=c(-0.295,-0.1),legend="(b)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

  legend("bottomleft", inset=c(0.01,-0.01), legend=c("Schoener","Boyce","cAUC","AUC","TSS"), col=coll, lty=1:5, lwd=4, bty="n", cex=2, )

dev.off()




# Supporting Information ##############################################################################################################################

# Figure S24 
pdf("FigS24.pdf", width=9.5625, height=6.420604, useDingbats=FALSE)

  par(mar=c(5,7,1,1))
 
  plot(spe$Size[spe$Site=="Trondheim"], spe$Bias[spe$Site=="Trondheim"], pch=16, col=colo[3], cex=1.5, xlim=c(0,600), ylim=c(-1,1), xlab="", ylab="", axes=FALSE) # Sample size x sample bias in Trondheim
  par(new=TRUE)
  plot(spe$Size[spe$Site=="Grote Nete"], spe$Bias[spe$Site=="Grote Nete"], pch=16, col=colo[1], cex=1.5, xlim=c(0,600), ylim=c(-1,1), xlab="", ylab="", axes=FALSE) # Sample size x sample bias in Grote Nete
  par(new=TRUE)
  plot(spe$Size[spe$Site=="Thau"], spe$Bias[spe$Site=="Thau"], pch=16, col=colo[2], cex=1.5, xlim=c(0,600), ylim=c(-1,1), xlab="", ylab="", axes=FALSE) # Sample size x sample bias in Thau
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("Sample size", 1, line=3.5, cex=2)
  mtext("Sample bias", 2, line=4.5, cex=2)
  box(lwd=1.5)

  legend("bottomright",inset=c(0,0) , pch=16, col=colo, legend=c("Grote Nete","Thau","Trondheim"), cex=1.8, bty="n", xpd=NA, text.font=2, pt.cex=1.5)

dev.off()


# Figure S25
pdf("FigS25.pdf", width=15.937500, height=6.19203, useDingbats=FALSE)

  par(mfrow=c(1,2))

  # a (ROI as a function of the sample size)
  par(mar=c(5,6.5,1,2))
  plot(roir$Nb.Occ[roir$Site=="Trondheim"], roir$ROI_Schoener[roir$Site=="Trondheim"], pch=16, col=colo[3], cex=1.5, xlim=c(0,600), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  par(new=TRUE)
  plot(roir$Nb.Occ[roir$Site=="Grote Nete"], roir$ROI_Schoener[roir$Site=="Grote Nete"], pch=16, col=colo[1], cex=1.5, xlim=c(0,600), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  par(new=TRUE)
  plot(roir$Nb.Occ[roir$Site=="Thau"], roir$ROI_Schoener[roir$Site=="Thau"], pch=16, col=colo[2], cex=1.5, xlim=c(0,600), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("Sample size", 1, line=3.5, cex=2)
  mtext("ROI (Schoener)", 2, line=4.5, cex=2)
  box(lwd=1.5)
  abline(h=0.02, col="grey", lwd=3)
  legend("topleft",inset=c(-0.325,-0.1),legend="(a)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

  legend("topright",inset=c(0,-0.01) , pch=16, col=colo, legend=c("Grote Nete","Thau","Trondheim"), cex=1.8, bty="n", xpd=NA, text.font=2, pt.cex=1.5)

  # b (ROI as a function the sample bias)
  par(mar=c(5,6.5,1,2))
  plot(roir$Sample.Bias[roir$Site=="Trondheim"], roir$ROI_Schoener[roir$Site=="Trondheim"], pch=16, col=colo[3], cex=1.5, xlim=c(-1,1), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  par(new=TRUE)
  plot(roir$Sample.Bias[roir$Site=="Grote Nete"], roir$ROI_Schoener[roir$Site=="Grote Nete"], pch=16, col=colo[1], cex=1.5, xlim=c(-1,1), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  par(new=TRUE)
  plot(roir$Sample.Bias[roir$Site=="Thau"], roir$ROI_Schoener[roir$Site=="Thau"], pch=16, col=colo[2], cex=1.5, xlim=c(-1,1), ylim=c(-0.1,0.6), xlab="", ylab="", axes=FALSE)
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("Sample bias", 1, line=3.5, cex=2)
  mtext("ROI (Schoener)", 2, line=4.5, cex=2)
  box(lwd=1.5)
  abline(h=0.02, col="grey", lwd=3)
  legend("topleft",inset=c(-0.325,-0.1),legend="(b)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

dev.off()


# Figure S26

#a
q=cut(roir$Nb.Occ, c(0,100,200,300,600), include.lowest=T, label=FALSE) # Divide the sample size into four categories
box=list()  
box[[1]]=roir$Schoener_pvalue[q==1]  # Distribution of p-value associated with a sample size ranging between 0 and 100
box[[2]]=roir$Schoener_pvalue[q==2]  # Distribution of p-value associated with a sample size ranging between 100 and 200
box[[3]]=roir$Schoener_pvalue[q==3]  # Distribution of p-value associated with a sample size ranging between 200 and 300
box[[4]]=roir$Schoener_pvalue[q==4]  # Distribution of p-value associated with a sample size higher than 300
b=boxplot(box, plot=F)
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
ba=b

#b
quantile(roir$Sample.Bias, seq(0,1,0.25))
q=cut(roir$Sample.Bias, c(-1,-0.5,0,0.5,1), include.lowest=T, label=FALSE) # Divide the sample bias into four categories
box=list()  
box[[1]]=roir$Schoener_pvalue[q==1] # Distribution of p-value associated with a sample bias ranging between -1 and -0.5
box[[2]]=roir$Schoener_pvalue[q==2] # Distribution of p-value associated with a sample bias ranging between -0.5 and 0
box[[3]]=roir$Schoener_pvalue[q==3] # Distribution of p-value associated with a sample bias ranging between 0 and 0.5
box[[4]]=roir$Schoener_pvalue[q==4] # Distribution of p-value associated with a sample bias ranging between 0.5 and 1
b=boxplot(box, plot=F)
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
bb=b

pdf("FigS26.pdf", width=17.947917, height=6.576444, useDingbats=FALSE)

   par(mfrow=c(1,2))

   # a
   par(mar=c(6,6.5,1.5,1))
       bxp(ba,at=c(1,2,3,4),outline=FALSE,boxcol="steelblue3",whiskcol="steelblue3",whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.5,staplecol="steelblue3",medbg="steelblue3",boxfill="steelblue3",cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
   axis(1, at=c(1,2,3,4), labels=c("[0,100[","[100,200[","[200,300[","[300,600]"), las=1, cex.axis=1.5, padj=-0.3, tick=FALSE)
   axis(2, las=1, cex.axis=1.5)
   mtext("Sample size", 1, line=4, cex=2)
   mtext("p-value (Schoener)", 2, line=4.25, cex=2)
   legend("topleft",inset=c(-0.27,-0.12),legend="(a)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

   # b
   par(mar=c(6,6.5,1.5,1)) 
      bxp(bb,at=c(1,2,3,4),outline=FALSE,boxcol="steelblue3",whiskcol="steelblue3",whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.5,staplecol="steelblue3",medbg="steelblue3",boxfill="steelblue3",cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
   axis(1, at=c(1,2,3,4), labels=c("[-1,-0.5[","[-0.5,0[","[0,0.5[","[0.5,1]"), las=1, cex.axis=1.5, padj=-0.3, tick=FALSE)
   axis(2, las=1, cex.axis=1.5)
   mtext("Sample bias", 1, line=4, cex=2)
   mtext("p-value (Schoener)", 2, line=4.25, cex=2)
   legend("topleft",inset=c(-0.27,-0.12),legend="(b)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

dev.off()


# Figure S27
tab=roir[,c(1,2,3,15)]     
tab[,1]=paste0(tab[,1], "_", tab[,2])
tab=tab[,-2]
colnames(tab)=c("ID","Model","pvalue")
temp=merge(tab$ID[!duplicated(tab$ID)],tab$Model[!duplicated(tab$Model)])
temp=data.frame(ID=temp[,1],Model=temp[,2],pvalue=10)
tab=rbind(tab,temp)
tab=tab[!duplicated(paste0(tab$ID,"_",tab$Model)),]
tab=as.matrix.xtabs(xtabs(tab[,3] ~ tab[,1] + tab[,2])) # p-value per species according to the modelling technique (10 = NA)

tabin=tab<0.05 # binary version of tab (1 if pvalue lower than 0.05)
tabin[tab==10]=NA # replace 10 per NA
tabin=data.frame(tabin,Nbinf=apply(tabin,1,sum,na.rm=TRUE),Nb=apply(!is.na(tabin),1,sum)) # Add the number of values equal to 1 (Nbinf) and the number of not NA values (Nb)
tabin$Ratio=tabin$Nbinf/tabin$Nb # Add a column Ratio between Nbinf and Nb
tabin[tabin$Ratio<0.5,1:8]=1-tabin[tabin$Ratio<0.5,1:8] # Adapt binary values to the majority (1 if in the majority, O otherwise)
tabin$Ratio[tabin$Ratio<0.5]=1-tabin$Ratio[tabin$Ratio<0.5] # Replace Ratio by 1-Ratio if Ratio is lower than 0.5 (in order to obtain the faction of models in the majority) 
tabin$Site=do.call(rbind,strsplit(rownames(tabin),"_"))[,2] # Add Site

box=NULL
box[[1]]=tabin$Ratio[tabin$Site=="Grote Nete"] # Fraction of models in the majority in Grote Nete
box[[2]]=tabin$Ratio[tabin$Site=="Thau"]       # Fraction of models in the majority in Thau
box[[3]]=tabin$Ratio[tabin$Site=="Trondheim"]  # Fraction of models in the majority in Trondheim
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}

probmod=NULL
probmod=rbind(probmod,apply(tabin[tabin$Site=="Grote Nete",1:8],2,sum,na.rm=TRUE)/apply(!is.na(tabin[tabin$Site=="Grote Nete",1:8]),2,sum)) # Fraction of species for wich each model is in the majority in Grote Nete
probmod=rbind(probmod,apply(tabin[tabin$Site=="Thau",1:8],2,sum,na.rm=TRUE)/apply(!is.na(tabin[tabin$Site=="Thau",1:8]),2,sum)) # Fraction of species for wich each model is in the majority in Thau
probmod=rbind(probmod,apply(tabin[tabin$Site=="Trondheim",1:8],2,sum,na.rm=TRUE)/apply(!is.na(tabin[tabin$Site=="Trondheim",1:8]),2,sum)) # Fraction of species for wich each model is in the majority in Trondheim
probmod=probmod[,order(apply(probmod,2,mean))] # Order probmod


pdf("FigS27.pdf", width=16.791667, height=7.158246, useDingbats=FALSE)

  par(mfrow=c(1,2))
 
  # a
  par(mar=c(4.5,6.5,1.5,1))   
  bxp(b,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0.5,1))
  axis(1, at=c(1,2,3), labels=c("Grote Nete","Thau","Trondheim"), las=1, cex.axis=1.5, padj=-0.5, tick=FALSE)
  axis(2, las=1, cex.axis=1.5)
  mtext("Case Study Site", 1, line=3, cex=2)
  mtext("Fraction of models in the majority", 2, line=4.25, cex=2)
  legend("topleft",inset=c(-0.295,-0.1),legend="(a)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

  # b
  par(mar=c(4.5,6.5,1.5,1))
  barplot(probmod, beside=TRUE, axes=FALSE, col=colo, border=colo, names.arg=rep(" ",8))
  axis(1, at=seq(2.5,32.5,4), labels=colnames(probmod), las=1, cex.axis=1.5, padj=-0.5, tick=FALSE)
  axis(2, las=1, cex.axis=1.5)
  mtext("Modelling technique", 1, line=3, cex=2)
  mtext("Fraction of species in the majority", 2, line=4.25, cex=2)
  legend("topleft",inset=c(-0.295,-0.1),legend="(b)",bty="n",cex=2.5,xpd=TRUE,text.font=2)

dev.off()


# Figure S28
pdf("FigS28.pdf", width=14.677083, height=6.732283, useDingbats=FALSE)

  par(mfrow=c(1,2))

  # Scatterplot ROI Schoener - Peason
  par(mar=c(5,7,1,1))
  plot(roir$ROI_Schoener,roir$ROI_Pearson, type="p",col="steelblue3", pch=16, cex=2, xlab="", ylab="", axes=FALSE, xlim=c(0,1), ylim=c(0,1))
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("ROI (Schoener)", 1, line=3.25, cex=2)
  mtext("ROI (Pearson)", 2, line=4, cex=2)
  box(lwd=1.5)
  abline(a=0, b=1, col="#CC6666", lwd=4)
  legend("topleft",inset=c(-0.4,-0.1),legend="(a)",bty="n",cex=3,xpd=TRUE,text.font=2)

  # Scatterplot ROI Schoener - Spearman
  par(mar=c(5,7,1,1))
  plot(roir$ROI_Schoener,roir$ROI_Spearman, type="p",col="steelblue3", pch=16, cex=2, xlab=" ", ylab="", axes=FALSE, xlim=c(0,1), ylim=c(0,1))
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("ROI (Schoener)", 1, line=3.25, cex=2)
  mtext("ROI (Spearman)", 2, line=4, cex=2)
  box(lwd=1.5)
  abline(a=0, b=1, col="#CC6666", lwd=4)
  legend("topleft",inset=c(-0.4,-0.1),legend="(b)",bty="n",cex=3,xpd=TRUE,text.font=2)

dev.off()


# Figure S29
pval=cbind(roir$ROI_Schoener,roir$Schoener_pvalue) # Select ROI and p-value (Schoener)
pval=pval[order(pval[,1]),] # Rank according to the ROI
pval=cbind(pval,pval[,2])
for(k in 1:dim(pval)[1]){ # Compute the fraction of p-value lower than 0.05 according to the ROI
  pval[k,3]=sum(pval[k:dim(pval)[1],2]<0.05)/length(k:dim(pval)[1])
}

pdf("FigS29.pdf", width=9.38, height=7, useDingbats=FALSE)

  par(mar=c(5,7,1,1))
  plot(pval[,1],pval[,3],type="l",col="steelblue3",lwd=4, xlab="", ylab="", axes=FALSE)  
  axis(1, las=1, cex.axis=1.75)
  axis(2, las=1, cex.axis=1.75)
  mtext("ROI (Shoener)", 1, line=3.5, cex=2)
  mtext("Fraction of significant difference", 2, line=5, cex=2)
  box(lwd=1.5)
  abline(v=0.02, col="#CC6666", lwd=4)

dev.off()


# Figure S30
box=NULL
box[[1]]=ovtrue$Pearson_pvalue[ovtrue$Site=="Grote Nete"] # Pearson p-value (true distribution) in Grote Nete
box[[2]]=ovtrue$Pearson_pvalue[ovtrue$Site=="Thau"]       # Pearson p-value (true distribution) in Thau
box[[3]]=ovtrue$Pearson_pvalue[ovtrue$Site=="Trondheim"]  # Pearson p-value (true distribution) in Trondheim
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
ba=b

box=NULL
box[[1]]=ovtrue$RMSE_pvalue[ovtrue$Site=="Grote Nete"] # RMSE p-value (true distribution) in Grote Nete
box[[2]]=ovtrue$RMSE_pvalue[ovtrue$Site=="Thau"]       # RMSE p-value (true distribution) in Thau
box[[3]]=ovtrue$RMSE_pvalue[ovtrue$Site=="Trondheim"]  # RMSE p-value (true distribution) in Trondheim
b=boxplot(box, plot=F) # Build boxplots
for(i in 1:length(box)){
   b$stats[1,i]=quantile(box[[i]],0.1,na.rm=TRUE)
   b$stats[5,i]=quantile(box[[i]],0.9,na.rm=TRUE)
}
bb=b

pdf("FigS30.pdf", width=16.791667, height=7.158246, useDingbats=FALSE)

  par(mfrow=c(1,2))

  # a
  par(mar=c(4.5,6.5,1.5,1))   
  bxp(ba,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
  axis(1, at=c(1,2,3), labels=c("Grote Nete","Thau","Trondheim"), las=1, cex.axis=1.5, padj=-0.5, tick=FALSE)
  axis(2, las=1, cex.axis=1.5)
  mtext("Case Study Site", 1, line=3, cex=2)
  mtext("p-value (Pearson)", 2, line=4.25, cex=2)
  legend("topleft",inset=c(-0.295,-0.1),legend="(a)",bty="n",cex=2.5,xpd=TRUE,text.font=2)
  abline(h=0.05, col="grey", lwd=3)

  # b
  par(mar=c(4.5,6.5,1.5,1))   
  bxp(bb,at=c(1,2,3),outline=FALSE,boxcol=colo,whiskcol=colo,whisklty="solid",whisklwd=3,staplelwd=3,boxwex=0.65,staplecol=colo,medbg=colo,boxfill=colo,cex.axis=1.5,las=1,axes=FALSE,xlab="",ylab="",ylim=c(0,1))
  axis(1, at=c(1,2,3), labels=c("Grote Nete","Thau","Trondheim"), las=1, cex.axis=1.5, padj=-0.5, tick=FALSE)
  axis(2, las=1, cex.axis=1.5)
  mtext("Case Study Site", 1, line=3, cex=2)
  mtext("p-value (RMSE)", 2, line=4.25, cex=2)
  legend("topleft",inset=c(-0.295,-0.1),legend="(b)",bty="n",cex=2.5,xpd=TRUE,text.font=2)
  abline(h=0.05, col="grey", lwd=3)

dev.off()









