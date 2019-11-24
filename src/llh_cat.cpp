#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List llh_cat(CharacterMatrix all_catpredictors,CharacterVector varname,CharacterVector y,int laplace){
  int nvar=all_catpredictors.ncol();
  List ret;
  Function f("table");

  for (int k =0; k<nvar ; k++){
    CharacterVector predictor=all_catpredictors(_,k);
    NumericMatrix table=f(y,predictor);
    NumericMatrix llh(table.nrow(),table.ncol());
    CharacterVector ch = colnames(table);
    colnames(llh) = ch;
    for (int i=0; i<table.nrow();i++){
      int rowsum=0;
      for (int j=0; j<table.ncol();j++){
        llh(i,j)=table(i,j)+laplace;
        rowsum+=table(i,j);
      }
      llh(i,_)=llh(i,_)/(rowsum+laplace*table.ncol());
    }
    String name=varname[k];
    ret[name]=llh;
  }
  return ret;
}
