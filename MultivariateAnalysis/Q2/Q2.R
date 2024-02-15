library(stats) 
library(RCurl)
library(robustbase)
library(lme4) 
library(MVN) 
library(CCP)
#install.packages("MVN", type="binary") 
#install.packages("robustbase", type="binary")

#################################################################
db<-read.table('Sales.txt',sep="",header=TRUE)
mvn(db,mvnTest = c("mardia"))

result<-mvn(data=db,mvnTest = c("dh"), desc = FALSE, 
            multivariateOutlierMethod = "adj", showOutliers = TRUE, showNewData = TRUE)

newcol<-result$newData
mvn(newcol,mvnTest = c("mardia"))
########################################################################


col<-scale(newcol)

newx<-cbind(col[,1],col[,2],col[,3]) 
newy<-cbind(col[,4],col[,5],col[,6],col[,7])

newcxy<-cancor(scale(newx, scale=T, center=T),scale(newy, scale=T, 
                                                    center=T))

print(newcxy)
##################################################################
xx<-scale(newx,scale=T,center=T) 
yy<-scale(newy,scale=T,center=T)

scorex<-xx%*%newcxy$xcoef[,1] 
scorey<-yy%*%newcxy$ycoef[,1] 
plot(scorex,scorey,type="n")
text(scorex,scorey)


print(cor(scorex,scorey))

###########################################################
rho<-newcxy$cor 
p.asym(rho,50,3,3,tstat="Wilks")






