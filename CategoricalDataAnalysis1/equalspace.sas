data table1;

input Income $Happiness $score1 $count @@;
datalines;

Above_average Not_Too_Happy 1 21 Above_average Pretty_Happy 2 159 Above_average Very_Happy 3 110
Average Not_Too_Happy 1 53 Average Pretty_Happy 2 372 Average Very_Happy 3 221
Below_average Not_Too_Happy 1 94 Below_average Pretty_Happy 2 249 Below_average Very_Happy 3 83
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




proc freq data=table1 order=data; /**/
	weight count;
	tables score1*income /CMH1 NOPRINT;
	EXACT TREND;
    title "Analysis of Income Happiness data EquallyÅ]Spaced Row Scores (1,2,3)";
run;
