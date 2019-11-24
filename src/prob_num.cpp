#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
List prob_num(int ly,CharacterVector ty,NumericMatrix newdata,List table){
  int entry=newdata.nrow();
  int lx=newdata.ncol();
  List all_prob;

  for (int i =0; i<ly; i++){
    NumericMatrix prob_y(entry,lx);
    for (int k =0; k<lx; k++){
      NumericMatrix x_prior=table[k];
      for (int j =0; j<entry; j++){
        if (NumericVector::is_na(newdata(j,k))){ newdata(j,k)=R_NegInf;}
      }
      double m=x_prior(i,0);
      double v=x_prior(i,1);
      prob_y(_,k)=dnorm(newdata(_,k),m,v,false);
    }
    String name=ty[i];
    all_prob[name]=prob_y;
  }
  return all_prob;
}
