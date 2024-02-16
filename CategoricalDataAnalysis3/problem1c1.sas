PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;
/*##################################################*/
/*Numerical: DuraCred CredAmnt Age*/
/*Binary: AcctBal PrevPay Savings CurrEmpl Gender House*/
/*####################################################*/
/*PROC LOGISTIC DATA=loan;
 MODEL Y(EVENT='0')=DuraCred CredAmnt Age AcctBal PrevPay Savings CurrEmpl Gender House;
*/
/*###########################################################################*/

PROC LOGISTIC DATA=loan;
 MODEL Y(EVENT='0')=DuraCred CredAmnt Age AcctBal PrevPay Savings CurrEmpl Gender House/SELECTION= Forward slentry=0.15 slstay=0.20 details lackfit;


/*DuraCred Age AcctBal PrevPay Savings CurrEmpl*/
/*
DuraCred 0.0337->0.0391 (16%)
Age -0.0152->-0.0115 (-24%)
AcctBal -1.4949->-1.5029 (0.53%)
PrevPay -1.0384->-1.0580 (1.88%)
Savings -0.6120->-0.6156 (0.58%)
CurrEmpl -0.4096->-0.4031 (-1.58%)
 */


RUN;

