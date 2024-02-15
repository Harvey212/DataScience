
library(ca)

db<-read.table("Fathers_Sons.txt",sep='',header=TRUE)

fisher.ca <- ca(db, nd=2)
print(fisher.ca)
#
plot(fisher.ca)

