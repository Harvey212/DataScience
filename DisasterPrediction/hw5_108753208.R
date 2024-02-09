library('rpart')
library(caret)
library(party)


# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("Rscript hw5_studentID.R --fold n --train Titanic_Data/train.csv --test Titanic_Data/test.csv --report performance.csv --predict predict.csv", call.=FALSE)
}

# parse parameters
j<-grep("-",c(args[1:length(args)]))


if(length(j)!=5){
  stop("you should type 5 argument", call.=FALSE)
}else{
  
  if((args[j[1]]=="--fold")|(args[j[2]]=="--fold")|(args[j[3]]=="--fold")|(args[j[4]]=="--fold")|(args[j[5]]=="--fold")){
    foldcheck<-1
  }else{
    stop("missing fold command", call.=FALSE)
  }
  
  
  
  if((args[j[1]]=="--train")|(args[j[2]]=="--train")|(args[j[3]]=="--train")|(args[j[4]]=="--train")|(args[j[5]]=="--train")){
    traincheck<-1
  }else{
    stop("missing train.csv", call.=FALSE)
  }
  
  
  
  if((args[j[1]]=="--test")|(args[j[2]]=="--test")|(args[j[3]]=="--test")|(args[j[4]]=="--test")|(args[j[5]]=="--test")){
    testcheck<-1
  }else{
    stop("missing test.csv", call.=FALSE)
  }
  
  
  
  if((args[j[1]]=="--report")|(args[j[2]]=="--report")|(args[j[3]]=="--report")|(args[j[4]]=="--report")|(args[j[5]]=="--report")){
    reportcheck<-1
  }else{
    stop("missing --report performance.csv", call.=FALSE)
  }
  
  
  if((args[j[1]]=="--predict")|(args[j[2]]=="--predict")|(args[j[3]]=="--predict")|(args[j[4]]=="--predict")|(args[j[5]]=="--predict")){
    predictcheck<-1
  }else{
    stop("missing --predict predict.csv", call.=FALSE)
  }
  
}





for(i in 1:5){
  judge<-j[i]
  
  if(args[judge]=="--fold"){
    FOLD<-args[judge+1]
  }else if(args[judge]=="--train"){
    TRdf<-args[judge+1]
  }else if(args[judge]=="--test"){
    Testdf<-args[judge+1]
  }else if(args[judge]=="--report"){
    Re_out<-args[judge+1]
  }else if(args[judge]=="--predict"){
    PRE_out<-args[judge+1]
  }else{
    stop("Unknown flag", call.=FALSE)
  }
  
}


FOLD<-as.numeric(FOLD)
INPUT <-read.csv(TRdf,na.strings="")
TEST <-read.csv(Testdf,na.strings="")

TESID<-TEST$PassengerId

##########################################################
#Not important

#INPUT$Cabin[INPUT$Cabin==""] <- NA
#INPUT$Cabin <- factor(INPUT$Cabin)
#TEST$Cabin[TEST$Cabin==""] <- NA
#TEST$Cabin <- factor(TEST$Cabin)

##
#INPUT$Survived[INPUT$Survived==""] <- NA
#INPUT$Pclass[INPUT$Pclass==""] <- NA
#INPUT$Sex[INPUT$Sex==""] <- NA
#INPUT$SibSp[INPUT$SibSp==""] <- NA
#INPUT$Parch[INPUT$Parch==""] <- NA
#INPUT$Fare[INPUT$Fare==""] <- NA

#sapply(INPUT,function(x) sum(is.na(x)))
##

##
#TEST$Embarked[TEST$Embarked==""] <- NA
#TEST$Pclass[TEST$Pclass==""] <- NA
#TEST$Sex[TEST$Sex==""] <- NA
#TEST$SibSp[TEST$SibSp==""] <- NA
#TEST$Parch[TEST$Parch==""] <- NA

#sapply(TEST,function(x) sum(is.na(x)))
##

######################################################################
#Pclass, Sex : Input, Test

INPUT$Pclass <- factor(INPUT$Pclass)
INPUT$Sex <- factor(INPUT$Sex)

TEST$Pclass <- factor(TEST$Pclass)
TEST$Sex <- factor(TEST$Sex)

#########################################################################
#Family Size:  Test + Input

INPUT$Name<-as.character(INPUT$Name)
TEST$Name<-as.character(TEST$Name)

INPUT$FamilySize <- INPUT$SibSp + INPUT$Parch + 1
TEST$FamilySize <- TEST$SibSp + TEST$Parch + 1

#################################################################################
#Title Input

INPUT$Title<-sapply(INPUT$Name,FUN=function(x){strsplit(x,split='[,.]')[[1]][2]})
INPUT$Title <- sub(' ', '',INPUT$Title)

#method1
INPUT$Title[INPUT$Title %in% c("Capt","Don","Major","Col","Rev","Dr","Sir","Mr","Jonkheer")] <- 'man'
INPUT$Title[INPUT$Title %in% c("Dona","the Countess","Mme","Mlle","Ms","Miss","Lady","Mrs")] <- 'woman'
INPUT$Title[INPUT$Title %in% c("Master")] <- 'boy'

#method2
#INPUT$Title[INPUT$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
#INPUT$Title[INPUT$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
#INPUT$Title[INPUT$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

##
#HAHA<-data.frame(table(INPUT$Title))
#print(HAHA)
##

INPUT$Title <- factor(INPUT$Title)
############################################################################
#Title test

TEST$Title<-sapply(TEST$Name,FUN=function(x){strsplit(x,split='[,.]')[[1]][2]})
TEST$Title <- sub(' ', '',TEST$Title)

#method1
TEST$Title[TEST$Title %in% c("Capt","Don","Major","Col","Rev","Dr","Sir","Mr","Jonkheer")] <- 'man'
TEST$Title[TEST$Title %in% c("Dona","the Countess","Mme","Mlle","Ms","Miss","Lady","Mrs")] <- 'woman'
TEST$Title[TEST$Title %in% c("Master")] <- 'boy'

#method2
#TEST$Title[TEST$Title %in% c('Mme', 'Mlle')] <- 'Mlle'
#TEST$Title[TEST$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
#TEST$Title[TEST$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

##
#HA<-data.frame(table(TEST$Title))
#print(HA)
##

TEST$Title <- factor(TEST$Title)


######################################################################
#Family ID: Input

#INPUT$Surname <- sapply(INPUT$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})
#INPUT$FamilyID <- paste(as.character(INPUT$FamilySize), INPUT$Surname, sep="")

#INPUT$FamilyID[INPUT$FamilySize <= 2] <- 'Small'

#famIDs <- data.frame(table(INPUT$FamilyID))
#famIDs1 <- famIDs[famIDs$Freq <= 2,]
#famIDs2 <- famIDs[famIDs$Freq > 2,]

#INPUT$FamilyID[INPUT$FamilyID %in% famIDs1$Var1]<-'Small'
#INPUT$FamilyID[INPUT$FamilyID %in% famIDs2$Var2]<-'big'
#INPUT$FamilyID <- factor(INPUT$FamilyID)

######################################################################
#Family ID: Test

#TEST$Surname <- sapply(TEST$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})
#TEST$FamilyID <- paste(as.character(TEST$FamilySize), TEST$Surname, sep="")

#TEST$FamilyID[TEST$FamilySize <= 2] <- 'Small'

#famIDst <- data.frame(table(TEST$FamilyID))
#famIDst1 <- famIDst[famIDst$Freq <= 2,]
#famIDst2 <- famIDst[famIDst$Freq > 2,]

#TEST$FamilyID[TEST$FamilyID %in% famIDst1$Var1] <- 'Small'
#TEST$FamilyID[TEST$FamilyID %in% famIDst2$Var2] <- 'big'
#TEST$FamilyID <- factor(TEST$FamilyID)



#########################################################################
#Ticket Count: Input 

ticket.count <- aggregate(INPUT$Ticket, by = list(INPUT$Ticket), function(x) sum(!is.na(x)))
INPUT$TicketCount <- apply(INPUT, 1, function(x) ticket.count[which(ticket.count[, 1] == x['Ticket']), 2])

INPUT$TicketCount <- factor(sapply(INPUT$TicketCount, function(x) ifelse(x > 1, 'Share', 'Unique')))

###########################################################################
#Ticket Count: Test

ticket.count2 <- aggregate(TEST$Ticket, by = list(TEST$Ticket), function(x) sum(!is.na(x)))
TEST$TicketCount <- apply(TEST, 1, function(x) ticket.count2[which(ticket.count2[, 1] == x['Ticket']), 2])

TEST$TicketCount <- factor(sapply(TEST$TicketCount, function(x) ifelse(x > 1, 'Share', 'Unique')))

########################################################################
#Embarked : Input ,Test(Not required to address since no N/A)

INPUT$Embarked[INPUT$Embarked==""] <- NA

#method1
#INPUT = INPUT[!is.na(INPUT$Embarked),]

#method2
INPUT$Embarked[is.na(INPUT$Embarked)]<-'C'

#print(levels(INPUT$Embarked))
#print(levels(TEST$Embarked))


INPUT$Embarked<-factor(INPUT$Embarked)
TEST$Embarked <-factor(TEST$Embarked)

##########################################################################
#Fare: Test, Input(Not required to address since no N/A)

#method1
#TEST$Fare[TEST$Fare==""] <- NA
#TEST = TEST[!is.na(TEST$Fare),]

#method2
TEST$Fare[is.na(TEST$Fare)] <- median(TEST$Fare, na.rm=TRUE)

##########################################################################3
#Age : Input, Test

#method1
#INPUT$Age[INPUT$Age==""] <- NA
#avg.age = mean(c(INPUT$Age, INPUT$Age), na.rm = T)
#INPUT$Age[is.na(INPUT$Age)] = avg.age

#TEST$Age[TEST$Age==""] <- NA
#TEST$Age[is.na(TEST$Age)] = avg.age

#method2
age.model <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize, data=INPUT[!is.na(INPUT$Age),], method="anova")

INPUT$Age[is.na(INPUT$Age)] <-predict(age.model, INPUT[is.na(INPUT$Age),])



age.model2 <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize, data=TEST[!is.na(TEST$Age),], method="anova")

TEST$Age[is.na(TEST$Age)] <-predict(age.model2, TEST[is.na(TEST$Age),])


################################################################################

#model1
DTree<-function(TRData,VAData)
{
  col<-dim(TRData)[2]
  
  TRgoal<-TRData[,col]
  TRattr<-TRData[,1:(col-1)]
  
  TEgoal<-VAData[,col]
  TEattr<-VAData[,1:(col-1)]

  fit<- rpart(TRgoal~., data =TRattr, method = 'class',model=TRUE,control=rpart.control(maxdepth=4))
  p1<-predict(fit,TEattr,type = "class")

  t1<-table(TEgoal,p1)

  acc1<-sum(diag(t1))/sum(t1)
  acc1<-format(round(acc1,2),nsmall=2)

  return(acc1)
}


save2<-0

#model2
RF<-function(TRData2,VAData2)
{
 set.seed(415)
 col2<-dim(TRData2)[2]
  
 TRgoal2<-TRData2[,col2]
 TRattr2<-TRData2[,1:(col2-1)]
  
 TEgoal2<-VAData2[,col2]
 TEattr2<-VAData2[,1:(col2-1)]
 
 
 assign("save2", TRgoal2, envir = .GlobalEnv)
 
 fit2 <- cforest(formula=save2~.,data = TRattr2, controls=cforest_unbiased(ntree=2000, mtry=5))
 p2 <- predict(object = fit2, newdata = TEattr2, OOB=TRUE, type = "response")

 cla<-ifelse(p2>=0.5,1,0)

 t2<-table(TEgoal2,cla)

 acc2<-sum(diag(t2))/sum(t2)
 acc2<-format(round(acc2,2),nsmall=2)

 return(acc2)
}

##################################################################################

savek<-0
savek2<-0

#cross validation
KCROSS<-function(TR,TE,foo)
{
  #same methodology as previous
  RR1<-dim(TR)[1]
  INTE<-as.integer(RR1/foo)
  
  #initialize accumulated validation accuracy
  ValidAcc1<-0
  ValidAcc2<-0
  
  #for final return
  Validcheck<-0
  traincheck<-0
  testcheck<-0
  
  for(i in 0:(foo-1))
  {
    #start of validation data
    ST1<-1+i*INTE
    
    #end of validation data
    if(i!=(foo-1))
    {
      EN1<-(i+1)*INTE
    }else
    {
      EN1<-RR1
    }
    
    #get validation data
    VALID<-TR[ST1:EN1,]
    
    #get the split of training data
    if(i==0)
    {
      REALTR<-TR[(EN1+1):RR1,]  
    }else if(i==(foo-1))
    {
      REALTR<-TR[1:(ST1-1),]
    }else
    {
      DD1<-TR[1:(ST1-1),]
      DD2<-TR[(EN1+1):RR1,]
      REALTR<-rbind(DD1,DD2)
    }
    
    #use training data and validation data to get the results of each model 
    m1<-DTree(REALTR,VALID)
    m2<-RF(REALTR,VALID)
    
    #accumulate the validation accuracy
    ValidAcc1<-ValidAcc1+as.numeric(m1)
    ValidAcc2<-ValidAcc2+as.numeric(m2)
    
  }
  
  #calculate the average validation accuracy of every surogate model
  ValidAcc1<-ValidAcc1/foo
  ValidAcc2<-ValidAcc2/foo
  ValidAcc1<-format(round(ValidAcc1,2),nsmall=2)
  ValidAcc2<-format(round(ValidAcc2,2),nsmall=2)
  
  #which model
  
  choice<-0
  
  #select training and testing attribute and goal
  CC1<-dim(TR)[2]
  
  TRGG<-TR[,CC1]
  TRATT<-TR[,1:(CC1-1)]
  
  TEGG<-TE[,CC1]
  TEATT<-TE[,1:(CC1-1)]
  
  assign("savek", TRGG, envir = .GlobalEnv)
  assign("savek2", TEGG, envir = .GlobalEnv)
  
  #judge which model is better
  if(ValidAcc1>ValidAcc2)
  {
    #fit the whole train data to model1
    fitT<- rpart(TRGG~., data =TRATT, method = 'class',model=TRUE,control=rpart.control(maxdepth=4))
    
    #get the predictive result of training data
    PTRAIN1<-predict(fitT,TRATT,type = "class")
    #get the predictive result of testing data
    PTEST1<-predict(fitT,TEATT,type = "class")
    
    #table the result
    TTRAIN1<-table(TRGG,PTRAIN1)
    TTEST1<-table(TEGG,PTEST1)
    
    #calculate training accuracy
    ACCTRAIN1<-sum(diag(TTRAIN1))/sum(TTRAIN1)
    ACCTRAIN1<-format(round(ACCTRAIN1,2),nsmall=2)
    
    #calculate testing accuracy
    ACCTEST1<-sum(diag(TTEST1))/sum(TTEST1)
    ACCTEST1<-format(round(ACCTEST1,2),nsmall=2)
    
    #confirm the return value
    traincheck<-ACCTRAIN1
    testcheck<-ACCTEST1
    Validcheck<-ValidAcc1
    
    choice<-1
  }else
  {
   
    set.seed(415)
    fit2T <- cforest(savek~. ,data = TRATT, controls=cforest_unbiased(ntree=2000, mtry=5))
    
    PTRAIN2<-predict(object = fit2T, newdata = TRATT, OOB=TRUE, type = "response")
    PTEST2<-predict(object = fit2T, newdata = TEATT, OOB=TRUE, type = "response")
    
    claTR<-ifelse(PTRAIN2>=0.5,1,0)
    claTE<-ifelse(PTEST2>=0.5,1,0)
    
    TTRAIN2<-table(savek,claTR)
    TTEST2<-table(savek2,claTE)
    
    ACCTRAIN2<-sum(diag(TTRAIN2))/sum(TTRAIN2)
    ACCTRAIN2<-format(round(ACCTRAIN2,2),nsmall=2)
    
    ACCTEST2<-sum(diag(TTEST2))/sum(TTEST2)
    ACCTEST2<-format(round(ACCTEST2,2),nsmall=2)
    
    traincheck<-ACCTRAIN2
    testcheck<-ACCTEST2
    Validcheck<-ValidAcc2
    
    choice<-2
  }
  
  #list the result
  my_list<-list(traincheck,testcheck,Validcheck,choice)
  
  return(my_list)
  
}


####################################################################################
INPUT <- subset(INPUT, select = c(Sex, Age, TicketCount, Title, FamilySize, Pclass, Fare, Embarked, Survived))
TEST <- subset(TEST, select = c(Sex, Age, TicketCount, Title, FamilySize, Pclass, Fare, Embarked))




#sapply(INPUT,function(x) sum(is.na(x)))
#sapply(TEST,function(x) sum(is.na(x)))


#FamilyID,  

#shuffle the data
set.seed(9850)
g<-runif(nrow(INPUT))
df<-INPUT[order(g),]

RR<-dim(df)[1]
CC<-dim(df)[2]

#interval of each fold
interval<-as.integer(RR/FOLD)

#get start point of test data
start<-1

#get end point of test data
end<-interval
  
#get test data
Tee<-df[start:end,]

#get train data
TRA<-df[(end+1):RR,]
TRfold<-FOLD-1

#retrieve value from cross validation
ANS<-KCROSS(TRA,Tee,TRfold)

#retrieve value
trAcc<-as.numeric(unlist(ANS[1]))
teAcc<-as.numeric(unlist(ANS[2]))
vaAcc<-as.numeric(unlist(ANS[3]))
chh<-as.numeric(unlist(ANS[4]))
#################################################################


#levels(TEST$Title) <- levels(df$Title)

final<-0
fTRgoal<-df[,CC]
fTRattr<-df[,1:(CC-1)]

fTEattr<-TEST[,1:(CC-1)]



if(chh==1)
{
  Ffit<- rpart(fTRgoal~., data =fTRattr, method = 'class',model=TRUE,control=rpart.control(maxdepth=4))
  
  final<-predict(Ffit,fTEattr,type = "class")
  
}else{
  
  set.seed(415)
  
  Ffit2 <- cforest(formula=fTRgoal~.,data = fTRattr, controls=cforest_unbiased(ntree=2000, mtry=5))
  p2 <- predict(object = Ffit2, newdata = fTEattr, OOB=TRUE, type = "response")
  
  final<-ifelse(p2>=0.5,1,0)
}


#######################################################################

#accuracy output
newdf<-data.frame(accuracy="ave.",training=trAcc,validation=vaAcc,testing=teAcc)
write.csv(newdf,file=Re_out,row.names=FALSE)

#prediction result
newdf2<-data.frame(PassengerId=TESID, Survived=final)
names(newdf2)<-c("PassengerId","Survived")
write.csv(newdf2,file=PRE_out,row.names=FALSE)





