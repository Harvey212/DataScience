PROC IMPORT OUT= loan
 DATAFILE= "Desktop\final\loan.txt"
 DBMS=TAB REPLACE;
 GETNAMES=YES;
 DATAROW=2;

/*plot*/
PROC LOGISTIC DATA=loan PLOT(ONLY)=ROC;
 MODEL Y(EVENT='0')=DuraCred|PrevPay DuraCred|Savings AcctBal|CurrEmpl/ LACKFIT
RSQUARE CTABLE PPROB=0 TO 1 BY 0.05 OUTROC=roc1;
 OUTPUT OUT=results P=pihat;



RUN;

