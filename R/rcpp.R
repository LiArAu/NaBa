cppFunction('NumericVector timesTwo(NumericVector a,DoubleVector b){
  NumericVector yy = dnorm(a,b,b);
  return yy;
}')
timesTwo(c(1,2,3))

cppFunction('NumericMatrix times(List a){
  NumericMatrix b=a[1];
  return b(1,[0,1,0]);
}')

times(prior$tables)
