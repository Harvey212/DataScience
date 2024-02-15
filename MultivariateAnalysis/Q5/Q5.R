
sub <- read.table("European_Jobs.txt",header=TRUE)
db<-cov(sub)

########################################
#spearman.mle<-factanal(covmat=as.matrix(db),factors=1,n.obs = 26)
#print(spearman.mle)
########################################
#spearman.mle2<-factanal(covmat=as.matrix(db),factors=2,n.obs=26)
#print(spearman.mle2, cutoff = 0.4)
############################################
output <- factanal(sub,factors=2,scores="Bartlett",rotation="promax")#
#print(output)

print(output, cutoff = 0.4)

plot(output$scores[,1],output$scores[,2],type="n",xlab= 'Factor 1', ylab='Factor 2')
text(output$scores[,1:2],row.names(sub),cex=0.8)

#####################################3

#output<-factanal(covmat=as.matrix(db),factors=2,rotation="promax",n.obs=26)

#print(output, cutoff = 0.4)
#plot(output$scores[,1],output$scores[,2],type="n",xlab= 'Factor 1', ylab='Factor 2')
#text(output$scores[,1:2],colnames(db),cex=0.8)

