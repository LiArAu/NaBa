
  #continuous

iris=as.data.frame(iris)
iris
x=iris[,1:4]
y=iris[,5]
newdata=iris[10:15,1:4]

#categorical
Titanic=as.data.frame(Titanic)
Titanic
newt=as.data.frame(Titanic[which(Titanic$Freq>0),])
newt
x=newt[,1:3]
y=newt[,4]
newdata=newt[10:14,1:3]

#my test data
set.seed(101)
test=data.frame(age=sample.int(40),sex=sample(c("girl","boy"),40,replace=T),
                weight=rnorm(40,100,10),
                local=sample(c("TRUE","FALSE"),40,replace=T),
                mood=sample(c("ok","good","excellent"),40,replace=T)
)
test
x=test[1:20,1:4]
y=test[1:20,5]
newdata=test[21:40,1:4]


source("Info_prior.R")
source("prep_newdata.R")
source("predict.naBa.R")


prior=Info_prior(x,y)
ppd_data=prep(prior,newdata)
myresult=predict.naBa(prior,ppd_data,"raw")
#prior$numvar_dist
#prior$catvar_conpro
myresult


#compared to e1071
prior2=e1071::naiveBayes(x,y)
e1071result=predict(prior2,newdata,"raw")
#prior2$tables
e1071result

