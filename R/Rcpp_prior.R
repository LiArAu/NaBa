
library(Rcpp)
cppFunction('
List pdist_num(NumericMatrix all_numpredictors,CharacterVector varname,CharacterVector y,CharacterVector type){
    int nvar=all_numpredictors.ncol();
    int l=y.length();
    int ltype=type.length();
    List ret;
    NumericVector sum(ltype);
    NumericVector mean(ltype);
    NumericVector squre_sum(ltype);
    NumericVector sd(ltype);

    for (int k =0; k<nvar ; k++){
    NumericVector predictor=all_numpredictors(_,k);
    NumericMatrix result(ltype,2);
    for (int j =0; j<ltype; j++){
    int count=0;
      for (int i =0; i<l ; i++){
        if (y[i]==type[j]){
          sum[j]+=predictor[i];
          squre_sum[j]+=predictor[i]*predictor[i];
          count++;
        }
      }
      mean[j]=sum[j]/=count;
      sd[j]=sqrt((squre_sum[j]-count*mean[j]*mean[j])/(count-1));
    }
    result(_,0)=mean;
    result(_,1)=sd;
    String name=varname[k];
    ret[name] = result;
    sum=0;
    squre_sum=0;
    mean=0;
    sd=0;
    result=0;
    }
    return ret;
            }')

cppFunction('List llh_cat(CharacterMatrix all_catpredictors,CharacterVector varname,CharacterVector y,int laplace){
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
   }')
