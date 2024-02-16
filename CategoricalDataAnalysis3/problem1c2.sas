PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;

/*
PROC LOGISTIC DATA=loan;
 MODEL Y(EVENT='0')=DuraCred Age AcctBal PrevPay Savings CurrEmpl;

slentry=0.15

DuraCred*Age (x)0.84
DuraCred*AcctBal (x) 0.4
DuraCred*CurrEmpl (x) 0.72
Age*AcctBal (x) 0.45
Age*PrevPay (x) 0.1536
Age*Savings (x) 0.56
Age*CurrEmpl (x) 0.3225
AcctBal*PrevPay (x) 0.807
AcctBal*Savings (x) 0.47

AcctBal*CurrEmpl (o) 0.01
PrevPay*Savings (o) 0.1239
PrevPay*CurrEmpl (o) 0.0624
Savings*CurrEmpl (o) 0.0757
DuraCred*PrevPay (o) 0.0018
DuraCred*Savings (o) 0.0078
*/

/*
PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred Age AcctBal PrevPay Savings CurrEmpl AcctBal*CurrEmpl PrevPay*Savings PrevPay*CurrEmpl Savings*CurrEmpl DuraCred*PrevPay DuraCred*Savings;
*/
/*###############################################*/
/*slstay=0.20*/

PROC LOGISTIC DATA=loan;
MODEL Y(EVENT='0')=DuraCred AcctBal PrevPay Savings CurrEmpl Age DuraCred*PrevPay DuraCred*Savings AcctBal*CurrEmpl PrevPay*CurrEmpl Savings*CurrEmpl;

/*
DuraCred 0.0391->0.00313 (-91.99%)
AcctBal -1.5029->-1.2147 (-19.17%)
PrevPay -1.0580->-2.0333 (92.18%)
Savings -0.6156->0.2352 (-138.20%)
CurrEmpl -0.4031->0.8370 (-307.64%)
Age -0.0115->-0.0106 (-7.8260%)
*/

RUN;

