
library(ca)
db<-read.table("Questionnaire.txt", h=T) 
dt<-db[,2:(dim(db))[2]]

##############################################
mammals.mca<-mjca(dt, nd=2, lambda="indicator")
summary(mammals.mca)
#print(mammals.mca)
###########################################

mammals.burt<-mjca(dt, nd=2, lambda="Burt") 
#print(mammals.mca)

summary(mammals.burt)

#plot(mammals.mca)
#plot(mammals.mca, what = c("all", "all"), col=c("blue","red"))
###############################################################

mammals.adj<-mjca(dt, nd=2, lambda="adjusted")
#print(mammals.mca)
summary(mammals.adj)
############################################

mammals.jca<-mjca(dt, nd=2, lambda="JCA") 
summary(mammals.jca)

plot(mammals.jca)
plot(mammals.jca, what = c("all", "all"), col=c("blue","red"))


