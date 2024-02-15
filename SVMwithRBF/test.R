fish<-read.table("fish.dat",h=T) 

#install.packages('e1071')

library(e1071) 

x<-fish[,2:7]
y<-as.factor(fish[,1])
  
#s<-svm(x,y)

#summary(s)

#pred<-predict(s,x)

#table(pred,y)


#s1<-svm(x,y,gamma=1)
#pred1<-predict(s1,x)
#table(pred1,y)

#s2<-svm(x,y,gamma=5)
#pred2<-predict(s2,x)
#table(pred2,y)

#s3<-svm(x,y,cost=10)
#pred3<-predict(s3,x)
#table(pred3,y)

#s4<-svm(x,y,cost=50)
#pred4<-predict(s4,x)
#table(pred4,y)


#s5<-svm(x,y,cost=50,gamma=10)
#pred5<-predict(s5,x)
#table(pred5,y)

#c1<-svm(x,y,cost=0.1,gamma=0.1,cross=10)
#summary(c1)


#c1<-svm(x,y,cost=0.5,gamma=0.1,cross=10)
#summary(c1)


search <- tune(svm, factor(Species) ~ ., data=fish, ranges=list(cost= 100*(1:10), gamma=0.1*(1:10)))
summary(search)
#search<-tune(svm, factor(Species) ~ ., data=fish, cost=seq(from=0.005, to=1,by=0.005), gamma = 1)

#summary(search)


#plot(search, xlab = "gamma", ylab="C")

#c1<-svm(x,y,cost=800,gamma=0.05)
#pred<-predict(c1,x)
#table(pred,y)

#test<-read.table("fish_test.dat",h=T)
#predict(c1,test)













