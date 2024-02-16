PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;

 /*################################################*/
/*PROC PRINT DATA=loan;
 VAR AcctBal DuraCred PrevPay CredAmnt Savings CurrEmpl Gender Age House;
 */
/*Numerical: DuraCred CredAmnt Age*/
/*Binary: AcctBal PrevPay Savings CurrEmpl Gender House*/
/*##############################################*/
/*###################################################*/
PROC UNIVARIATE DATA=loan;
  VAR DuraCred CredAmnt Age;

/*######################################################*/
PROC MEANS DATA=loan;
  CLASS AcctBal;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS PrevPay;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS CurrEmpl;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS Savings;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS Gender;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS House;
  VAR DuraCred CredAmnt Age;
PROC MEANS DATA=loan;
  CLASS Y;
  VAR DuraCred CredAmnt Age;
/*###########################################*/

RUN;
