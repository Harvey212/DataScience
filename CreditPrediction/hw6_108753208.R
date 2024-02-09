library('rpart')
library(caret)
library(party)
library(varhandle)


# read parameters
args = commandArgs(trailingOnly=TRUE)
if (length(args)==0) {
  stop("Rscript hw6_studentID.R --fold n --train Titanic_Data/train.csv --test Titanic_Data/test.csv --report performance.csv --predict predict.csv", call.=FALSE)
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


RR<-dim(INPUT)[1]
CC<-dim(INPUT)[2]

rr<-dim(TEST)[1]
cc<-dim(TEST)[2]

#############################################################

INPUT<-INPUT[!(INPUT$NumberOfTime30.59DaysPastDueNotWorse==96 | INPUT$NumberOfTime30.59DaysPastDueNotWorse==98),]

INPUT<-INPUT[!(INPUT$NumberOfTime60.89DaysPastDueNotWorse==96 | INPUT$NumberOfTime60.89DaysPastDueNotWorse==98),]

INPUT<-INPUT[!(INPUT$NumberOfTimes90DaysLate==96 | INPUT$NumberOfTimes90DaysLate==98),]

INPUT <- INPUT[INPUT$age <= 65 & INPUT$age >= 18,]

###########################################################
INPUTID<-INPUT[,1]
TESTID<-TEST[,1]

realY<-INPUT[,2]
realInput<-INPUT[,3:CC]

testInput<-TEST[,3:cc]


##################################################################33
#RevolvingUtilizationOfUnsecuredLines
#age
#NumberOfTime30.59DaysPastDueNotWorse
#DebtRatio
#MonthlyIncome
#NumberOfOpenCreditLinesAndLoans
#NumberOfTimes90DaysLate
#NumberRealEstateLoansOrLines
#NumberOfTime60.89DaysPastDueNotWorse
#NumberOfDependents


realInput$RevolvingUtilizationOfUnsecuredLines[realInput$RevolvingUtilizationOfUnsecuredLines==""] <- NA
realInput$age[realInput$age==""] <- NA
realInput$NumberOfTime30.59DaysPastDueNotWorse[realInput$NumberOfTime30.59DaysPastDueNotWorse==""] <- NA
realInput$DebtRatio[realInput$DebtRatio==""] <- NA
realInput$MonthlyIncome[realInput$MonthlyIncome==""] <- NA
realInput$NumberOfOpenCreditLinesAndLoans[realInput$NumberOfOpenCreditLinesAndLoans==""] <- NA
realInput$NumberOfTimes90DaysLate[realInput$NumberOfTimes90DaysLate==""] <- NA
realInput$NumberRealEstateLoansOrLines[realInput$NumberRealEstateLoansOrLines==""] <- NA
realInput$NumberOfTime60.89DaysPastDueNotWorse[realInput$NumberOfTime60.89DaysPastDueNotWorse==""] <- NA
realInput$NumberOfDependents[realInput$NumberOfDependents==""] <- NA

realInput$RevolvingUtilizationOfUnsecuredLines[realInput$RevolvingUtilizationOfUnsecuredLines=="NA"] <- NA
realInput$age[realInput$age=="NA"] <- NA
realInput$NumberOfTime30.59DaysPastDueNotWorse[realInput$NumberOfTime30.59DaysPastDueNotWorse=="NA"] <- NA
realInput$DebtRatio[realInput$DebtRatio=="NA"] <- NA
realInput$MonthlyIncome[realInput$MonthlyIncome=="NA"] <- NA
realInput$NumberOfOpenCreditLinesAndLoans[realInput$NumberOfOpenCreditLinesAndLoans=="NA"] <- NA
realInput$NumberOfTimes90DaysLate[realInput$NumberOfTimes90DaysLate=="NA"] <- NA
realInput$NumberRealEstateLoansOrLines[realInput$NumberRealEstateLoansOrLines=="NA"] <- NA
realInput$NumberOfTime60.89DaysPastDueNotWorse[realInput$NumberOfTime60.89DaysPastDueNotWorse=="NA"] <- NA
realInput$NumberOfDependents[realInput$NumberOfDependents=="NA"] <- NA


#sapply(realInput,function(x) sum(is.na(x)))
#print(class(realInput$RevolvingUtilizationOfUnsecuredLines))
#print(class(realInput$age))
#print(class(realInput$NumberOfTime30.59DaysPastDueNotWorse))
#print(class(realInput$DebtRatio))
#print(class(realInput$MonthlyIncome))
#print(class(realInput$NumberOfOpenCreditLinesAndLoans))
#print(class(realInput$NumberOfTimes90DaysLate))
#print(class(realInput$NumberRealEstateLoansOrLines))
#print(class(realInput$NumberOfTime60.89DaysPastDueNotWorse))
#print(class(realInput$NumberOfDependents))
#print(class(realInput$MonthlyIncome))

#MonthlyIncome
realInput$MonthlyIncome<-unfactor(realInput$MonthlyIncome)
realInput$MonthlyIncome[is.na(realInput$MonthlyIncome)] <- median(realInput$MonthlyIncome[!is.na(realInput$MonthlyIncome)])

#NumberOfDependents
realInput$NumberOfDependents<-unfactor(realInput$NumberOfDependents)

#method1
#realInput$NumberOfDependents[is.na(realInput$NumberOfDependents)] <- Mode(realInput$NumberOfDependents, na.rm=TRUE)

#method2
realInput$due<-realInput$NumberOfTime30.59DaysPastDueNotWorse+realInput$NumberOfTime60.89DaysPastDueNotWorse+realInput$NumberOfTimes90DaysLate

DD.model <- rpart(NumberOfDependents ~RevolvingUtilizationOfUnsecuredLines+age+DebtRatio+MonthlyIncome+NumberOfOpenCreditLinesAndLoans+NumberRealEstateLoansOrLines+due, data=realInput[!is.na(realInput$NumberOfDependents),], method="anova")
realInput$NumberOfDependents[is.na(realInput$NumberOfDependents)] <-predict(DD.model, realInput[is.na(realInput$NumberOfDependents),])

realY[realY==""]<-NA
realY[realY=="NA"]<-NA
#sapply(realY,function(x) sum(is.na(x)))
#print(class(realY))

INN <- subset(realInput, select = c(RevolvingUtilizationOfUnsecuredLines,age,DebtRatio,MonthlyIncome,NumberOfOpenCreditLinesAndLoans,NumberRealEstateLoansOrLines,NumberOfDependents,due))

df <- cbind(INN,realY)

#sapply(df,function(x) sum(is.na(x)))
#unique(realY)
#print(head(df))

##############################################################################33

testInput$RevolvingUtilizationOfUnsecuredLines[testInput$RevolvingUtilizationOfUnsecuredLines==""] <- NA
testInput$age[testInput$age==""] <- NA
testInput$NumberOfTime30.59DaysPastDueNotWorse[testInput$NumberOfTime30.59DaysPastDueNotWorse==""] <- NA
testInput$DebtRatio[testInput$DebtRatio==""] <- NA
testInput$MonthlyIncome[testInput$MonthlyIncome==""] <- NA
testInput$NumberOfOpenCreditLinesAndLoans[testInput$NumberOfOpenCreditLinesAndLoans==""] <- NA
testInput$NumberOfTimes90DaysLate[testInput$NumberOfTimes90DaysLate==""] <- NA
testInput$NumberRealEstateLoansOrLines[testInput$NumberRealEstateLoansOrLines==""] <- NA
testInput$NumberOfTime60.89DaysPastDueNotWorse[testInput$NumberOfTime60.89DaysPastDueNotWorse==""] <- NA
testInput$NumberOfDependents[testInput$NumberOfDependents==""] <- NA

testInput$RevolvingUtilizationOfUnsecuredLines[testInput$RevolvingUtilizationOfUnsecuredLines=="NA"] <- NA
testInput$age[testInput$age=="NA"] <- NA
testInput$NumberOfTime30.59DaysPastDueNotWorse[testInput$NumberOfTime30.59DaysPastDueNotWorse=="NA"] <- NA
testInput$DebtRatio[testInput$DebtRatio=="NA"] <- NA
testInput$MonthlyIncome[testInput$MonthlyIncome=="NA"] <- NA
testInput$NumberOfOpenCreditLinesAndLoans[testInput$NumberOfOpenCreditLinesAndLoans=="NA"] <- NA
testInput$NumberOfTimes90DaysLate[testInput$NumberOfTimes90DaysLate=="NA"] <- NA
testInput$NumberRealEstateLoansOrLines[testInput$NumberRealEstateLoansOrLines=="NA"] <- NA
testInput$NumberOfTime60.89DaysPastDueNotWorse[testInput$NumberOfTime60.89DaysPastDueNotWorse=="NA"] <- NA
testInput$NumberOfDependents[testInput$NumberOfDependents=="NA"] <- NA

#sapply(testInput,function(x) sum(is.na(x)))
#print(class(testInput$RevolvingUtilizationOfUnsecuredLines))
#print(class(testInput$age))
#print(class(testInput$NumberOfTime30.59DaysPastDueNotWorse))
#print(class(testInput$DebtRatio))
#print(class(testInput$MonthlyIncome))
#print(class(testInput$NumberOfOpenCreditLinesAndLoans))
#print(class(testInput$NumberOfTimes90DaysLate))
#print(class(testInput$NumberRealEstateLoansOrLines))
#print(class(testInput$NumberOfTime60.89DaysPastDueNotWorse))
#print(class(testInput$NumberOfDependents))
#print(class(testInput$MonthlyIncome))


#MonthlyIncome
testInput$MonthlyIncome<-unfactor(testInput$MonthlyIncome)
testInput$MonthlyIncome[is.na(testInput$MonthlyIncome)] <- median(testInput$MonthlyIncome[!is.na(testInput$MonthlyIncome)])

#NumberOfDependents
testInput$NumberOfDependents<-unfactor(testInput$NumberOfDependents)

#method1
#testInput$NumberOfDependents[is.na(testInput$NumberOfDependents)] <- Mode(testInput$NumberOfDependents, na.rm=TRUE)

#method2
testInput$due<-testInput$NumberOfTime30.59DaysPastDueNotWorse+testInput$NumberOfTime60.89DaysPastDueNotWorse+testInput$NumberOfTimes90DaysLate

DD.model2 <- rpart(NumberOfDependents ~RevolvingUtilizationOfUnsecuredLines+age+DebtRatio+MonthlyIncome+NumberOfOpenCreditLinesAndLoans+NumberRealEstateLoansOrLines+due, data=testInput[!is.na(testInput$NumberOfDependents),], method="anova")
testInput$NumberOfDependents[is.na(testInput$NumberOfDependents)] <-predict(DD.model2, testInput[is.na(testInput$NumberOfDependents),])

finaltest <- subset(testInput, select = c(RevolvingUtilizationOfUnsecuredLines,age,DebtRatio,MonthlyIncome,NumberOfOpenCreditLinesAndLoans,NumberRealEstateLoansOrLines,NumberOfDependents,due))
#sapply(finaltest,function(x) sum(is.na(x)))

########################################################################
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

#model3
GLM<-function(TRData3,VAData3)
{
  col3<-dim(TRData3)[2]
  
  TRgoal3<-TRData3[,col3]
  TRattr3<-TRData3[,1:(col3-1)]
  
  TEgoal3<-VAData3[,col3]
  TEattr3<-VAData3[,1:(col3-1)]
  
  fit <- glm(TRgoal3~.,data =TRattr3,family=binomial(link = "logit"))
  p3<-predict(fit,newdata = TEattr3 ,type="response")
  
  cla2<-ifelse(p3>=0.5,1,0)

  t3<-table(TEgoal3,cla2)
  
  acc3<-sum(diag(t3))/sum(t3)
  acc3<-format(round(acc3,2),nsmall=2)
  
  return(acc3)
  
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
    #m2<-RF(REALTR,VALID)
    m2<-GLM(REALTR,VALID)
    
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
  
  #assign("savek", TRGG, envir = .GlobalEnv)
  #assign("savek2", TEGG, envir = .GlobalEnv)
  
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
    
    fit2T <- glm(TRGG~.,data =TRATT,family=binomial(link = "logit"))
    
    PTRAIN2<-predict(fit2T,newdata = TRATT ,type="response")
    PTEST2<-predict(fit2T,newdata = TEATT ,type="response")
    
    claTR<-ifelse(PTRAIN2>=0.5,1,0)
    claTE<-ifelse(PTEST2>=0.5,1,0)
    
    TTRAIN2<-table(TRGG,claTR)
    TTEST2<-table(TEGG,claTE)
    
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

#shuffle the data
set.seed(9850)
g<-runif(nrow(df))
data<-df[order(g),]

RR<-dim(data)[1]
CC<-dim(data)[2]

#interval of each fold
interval<-as.integer(RR/FOLD)

#get start point of test data
start<-1

#get end point of test data
end<-interval

#get test data
Tee<-data[start:end,]

#get train data
TRA<-data[(end+1):RR,]
TRfold<-FOLD-1


#retrieve value from cross validation
ANS<-KCROSS(TRA,Tee,TRfold)

#retrieve value
trAcc<-as.numeric(unlist(ANS[1]))
teAcc<-as.numeric(unlist(ANS[2]))
vaAcc<-as.numeric(unlist(ANS[3]))
chh<-as.numeric(unlist(ANS[4]))
#################################################################

##levels(TEST$Title) <- levels(df$Title)

final<-0
fTRgoal<-data[,CC]
fTRattr<-data[,1:(CC-1)]

fTEattr<-finaltest[,1:(CC-1)]


if(chh==1)
{
  Ffit<- rpart(fTRgoal~., data =fTRattr, method = 'class',model=TRUE,control=rpart.control(maxdepth=4))
  tt<-predict(Ffit,fTEattr,type = "prob")
  final<-tt[,2]
  
}else{
  
  Ffit2 <- glm(fTRgoal~.,data =fTRattr,family=binomial(link = "logit"))
  
  p2<-predict(Ffit2,newdata = fTEattr ,type="response")
 
  #final<-ifelse(p2>=0.5,1,0)
  final<-p2
}




#######################################################################

#accuracy output
newdf<-data.frame(accuracy="ave.",training=trAcc,validation=vaAcc,testing=teAcc)
write.csv(newdf,file=Re_out,row.names=FALSE)

#prediction result
newdf2<-data.frame(Id=TESTID, Probability=final)
names(newdf2)<-c("Id","Probability")
write.csv(newdf2,file=PRE_out,row.names=FALSE)





