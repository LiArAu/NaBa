#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
NumericVector timesTwo(CharacterMatrix x, Function f){
  return f(x);
}


/*** R
Titanic=as.data.frame(Titanic)
newt=as.data.frame(Titanic[which(Titanic$Freq>0),])
x=newt[,1:3]
timesTwo(x,table)
*/


