library(pls)
library(lmvar)


INPUT <-read.csv('2020-QS-World-University-Rankings-100.csv',header=TRUE)
row<-dim(INPUT)[1]
col<-dim(INPUT)[2]

y<-INPUT[1:row,3] #academic_reputation

x1<-INPUT[1:row,4] #employer_reputation
x2<-INPUT[1:row,5] #Faculty_Student
x3<-INPUT[1:row,6] #Faculty_Citation
x4<-INPUT[1:row,7] #International_Faculty
x5<-INPUT[1:row,8] #International_Students

least_square<-lm(y~x1+x2+x3+x4+x5-1,y =TRUE,x=TRUE)
pcr_model <- pcr(y~x1+x2+x3+x4+x5-1,scale = TRUE, validation = "CV")
plsr_model <- plsr(y~x1+x2+x3+x4+x5-1,scale=TRUE, validation="CV")
#####################################################################################
summary(least_square)
print(cv.lm(least_square,k=10))
###############################################
summary(pcr_model)
validationplot(pcr_model, val.type = "RMSEP")
#####################################################
summary(plsr_model)
validationplot(plsr_model, val.type = "RMSEP")








