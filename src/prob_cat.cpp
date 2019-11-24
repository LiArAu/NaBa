#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
List prob_cat(int ly,CharacterVector ty,CharacterMatrix newdata,List table){
  int entry=newdata.nrow();
  int lx=newdata.ncol();
  List all_prob;
  Function R_match("match");

  for (int i =0; i<ly; i++){
    NumericMatrix prob_y(entry,lx);
    for (int k =0; k<lx; k++){
      NumericMatrix x_prior=table[k];
      NumericVector pos = R_match(newdata(_,k),colnames(x_prior));
      for (int j =0; j<entry; j++){
        NumericVector m=x_prior(i,_);
        prob_y(j,k)=m[pos[j]-1];
      }}
    String name=ty[i];
    all_prob[name]=prob_y;
  }
  return all_prob;
}
