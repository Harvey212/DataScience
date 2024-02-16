data lungcancer;
input therapy $ gender $ response $ value;
cards;

sequential male prog 28
sequential male no 45
sequential male partial 29
sequential male complete 26

sequential female prog 4
sequential female no 12
sequential female partial 5
sequential female complete 2

alternating male prog 41
alternating male no 44
alternating male partial 20 
alternating male complete 20

alternating female prog 12
alternating female no 7
alternating female partial 3  
alternating female complete 1
;

proc logist data=lungcancer;
 freq value;
 class therapy gender/order=data param=ref;
 model response(order=data) =therapy gender therapy*gender/link=logit
  aggregate=(therapy gender) scale=none;

run;
