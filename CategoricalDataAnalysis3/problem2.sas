data gator;
 input lake $ size $ food $ count;
 cards;
Hancock <=2.3 fish 23
Hancock <=2.3 invertebrate 4
Hancock <=2.3 reptile 2
Hancock <=2.3 bird 2
Hancock <=2.3 other 8

Hancock >2.3 fish 7
Hancock >2.3 invertebrate 0
Hancock >2.3 reptile 1
Hancock >2.3 bird 3
Hancock >2.3 other 5

Oklawaha <=2.3 fish 5
Oklawaha <=2.3 invertebrate 11
Oklawaha <=2.3 reptile 1
Oklawaha <=2.3 bird 0
Oklawaha <=2.3 other 3

Oklawaha >2.3 fish 13
Oklawaha >2.3 invertebrate 8 
Oklawaha >2.3 reptile 6
Oklawaha >2.3 bird 1
Oklawaha >2.3 other 0

Trafford <=2.3 fish 5
Trafford <=2.3 invertebrate 11 
Trafford <=2.3 reptile 2
Trafford <=2.3 bird 1
Trafford <=2.3 other 5

Trafford >2.3 fish 8
Trafford >2.3 invertebrate 7  
Trafford >2.3 reptile 6
Trafford >2.3 bird 3
Trafford >2.3 other 5

George <=2.3 fish 16
George <=2.3 invertebrate 19  
George <=2.3 reptile 1
George <=2.3 bird 2
George <=2.3 other 3

George >2.3 fish 17
George >2.3 invertebrate 1  
George >2.3 reptile 0
George >2.3 bird 1
George >2.3 other 3
;

proc logist data=gator;
freq count;
class lake size /order=data param=ref;
model food(ref='fish')=lake size/link=glogit
 aggregate=(lake size) scale=none;

run;
