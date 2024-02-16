PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;
/*##################################################*/
/*Numerical: DuraCred CredAmnt Age*/
/*Binary: AcctBal PrevPay Savings CurrEmpl Gender House*/
/*####################################################*/
/*STEP0: fit the univariate logistic model for each covariate. You have to make dummy variable yourself*/
/*
PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=CredAmnt;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=Age;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=AcctBal;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=PrevPay;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=Savings;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=CurrEmpl;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=House;

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=Gender;
*/
/*Gender is insignificant*/
/*######################################################################*/
/*STEP1:fit the model in step 0*/
/*PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred CredAmnt Age AcctBal PrevPay Savings CurrEmpl House;
*/
/*#######################################################################*/
/*STEP2: alpha=0.05, fit a multivariate model that are significant in step1.remove the insignificant variable in STEP2, and fit again. Note that if it is a binary variable
, we have to remove all the dummies relevant.*/

 /*PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred AcctBal PrevPay Savings CurrEmpl;
 */
/*##################################################################*/

/*STEP3: 
Check beta to see if delta beta between step2 and step3 are more than 20% compared to old model.
If you find that delta beta is > 20%, then you cannot remove the variable in the first place.
*/

/*
DuraCred  0.0338->0.0395 (16.8%)
AcctBal -1.4932->-1.5073 (0.9%)
PrevPay -1.0431->-1.0533 (0.97%)
Savings -0.6126->-0.6120 (0.09%)
CurrEmpl -0.4071->-0.4705 (15.57%)

=> We can remove, NO problem!
*/

/*#####################################################*/
/*STEP4: Try to add back the variables you delete in step1 one by one to see if it is still insignificant.
Besides, if you have 3 categories in the first place, and you find 1 of the variable insignificant, then you can
combine 2 categories into one. 
*/
/*
CredAmnt(x) Age(x) Gender(x) House(x)
=>NO adding back
*/

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred AcctBal PrevPay Savings CurrEmpl;


/*#######################################################*/
/*STEP5: check if the continuous variable is linear*/
/*skip*/

RUN;

