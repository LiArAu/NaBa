#try naiveBayes in e1071
library(e1071)
data(Titanic)
m <- naiveBayes(Survived ~ ., data = Titanic)
m
new1=as.data.frame(Titanic)[1:3,]
new1
new2=as.data.frame(Titanic)[1:2,-2]
new2
new3=new2
new3[1,2]=NA
new3
predict(m, new3)


## Example with metric predictors:
data(iris)
m <- naiveBayes(Species ~ ., data = iris)
## alternatively:
m <- naiveBayes(iris[,-5], iris[,5])
m
table(predict(m, iris), iris[,5])

Titanic=as.data.frame(Titanic)
Titanic
newt=as.data.frame(Titanic[which(Titanic$Freq>0),])
newt
x=newt[,1:3]
y=newt[,4]
