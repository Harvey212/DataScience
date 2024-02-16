
data table2;

input Income $ Happiness $ count @@;
datalines;

Above_average Not_Too_Happy 21 Above_average Pretty_Happy 159 Above_average Very_Happy 110
Average Not_Too_Happy 53 Average Pretty_Happy 372 Average Very_Happy 221
Below_average Not_Too_Happy 94 Below_average Pretty_Happy 249 Below_average Very_Happy 83
;

PROC FORMAT;
VALUE income
5='Above_average'
3='Average'
1='Below_average'
;


PROC FORMAT;
VALUE happiness
5='Very_Happy'
3='Pretty_Happy'
1='Not_Too_Happy'
;




proc freq data=table2 order=data; /**/
	weight count;
	tables income*happiness /CMH1 SCORES=RIDIT NOPRINT;
	EXACT TREND;
    title "Analysis of Income Happiness data Midranks";
run;
