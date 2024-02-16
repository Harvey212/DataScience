PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;

/*STEP6: Explore possible interaction, add one pair one by one to see if it is significant.*/
/*
PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred AcctBal PrevPay Savings CurrEmpl;


DuraCred*AcctBal (x)
DuraCred*CurrEmpl (x)
AcctBal*PrevPay (x)
AcctBal*Savings (x)
PrevPay*Savings (x)
PrevPay*CurrEmpl (x)
Savings*CurrEmpl (x)

DuraCred*PrevPay (o)
DuraCred*Savings (o)
AcctBal*CurrEmpl (o)
*/

/*######################################################3*/
/*STEP7: fit the model containing the significant interaction in STEP6. 
remove the one that is insignificant, and fit the model again.*/


PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred AcctBal PrevPay Savings CurrEmpl DuraCred*PrevPay DuraCred*Savings AcctBal*CurrEmpl;

/*do not need to remove anything. this is the final model*/
/*###############################################################3*/
RUN;

