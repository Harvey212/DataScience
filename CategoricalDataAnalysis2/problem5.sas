
Data cmh;
	INPUT hospital operation severity count @@;
	CARDS;

1 1 1 23 1 1 2 7 1 1 3 2 2 1 1 18 2 1 2 6 2 1 3 1 3 1 1 8 3 1 2 6 3 1 3 3 4 1 1 12 4 1 2 9 4 1 3 1
1 2 1 23 1 2 2 10 1 2 3 5 2 2 1 18 2 2 2 6 2 2 3 2 3 2 1 12 3 2 2 4 3 2 3 4 4 2 1 15 4 2 2 3 4 2 3 2
1 3 1 20 1 3 2 13 1 3 3 5 2 3 1 13 2 3 2 13 2 3 3 2 3 3 1 11 3 3 2 6 3 3 3 2 4 3 1 14 4 3 2 8 4 3 3 3
1 4 1 24 1 4 2 10 1 4 3 6 2 4 1 9 2 4 2 15 2 4 3 2 3 4 1 7 3 4 2 7 3 4 3 4 4 4 1 13 4 4 2 6 4 4 3 4
;


PROC FREQ DATA=cmh;
	WEIGHT count;
	TABLES hospital*operation*severity/NOPRINT CMH;
	TITLE2 "All";
