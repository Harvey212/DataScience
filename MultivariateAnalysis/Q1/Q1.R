library(stats) 
library(RCurl)

db<-read.table('European_Jobs.txt',sep="",header=TRUE)
sign.pc<-function(x,R=1000,m=length(x), cor=T)
{
  
  # run PCA
  
  pc.out<-princomp(x,cor=cor)
  
  # the proportion of variance of each PC
  
  pve=(pc.out$sdev^2/m)[1:m]
  
  # a matrix with R rows and m columns that contains
  
  # the proportion of variance explained by each pc
  
  # for each randomization replicate.
  
  pve.perm<-matrix(NA,ncol=m,nrow=R)
  
  for(i in 1:R)
    {
    
    # permutation each column
    
    x.perm<-apply(x,2,sample)
    
    # run PCA
    
    pc.perm.out<-princomp(x.perm,cor=cor)
    
    # the proportion of variance of each PC.perm
    
    pve.perm[i,]=(pc.perm.out$sdev^2/m)[1:m]
    
  }
  
  # calcalute the p-values
  
  pval<-apply(t(pve.perm)>pve,1,sum)/R
  
  return(list(pve=pve,pval=pval))
  
}


sign.pc(db,cor=T)

###############################################

pca.crime<-princomp(db,cor=TRUE) 
summary(pca.crime)
############################################

eigen<-eigen(cor(db))
plot(eigen$values,type="h") 
############################################
pcs.crime<-predict(pca.crime) 
plot(pcs.crime[,1:2],type="n",xlab='1st PC',ylab='2nd PC')
text(pcs.crime[,1:2],row.names(db)) 

##########################################
biplot(pca.crime,scale=1) 

loadings(pca.crime)




