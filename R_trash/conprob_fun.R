library(Rcpp)
#for numeric variables

cppFunction('
List pdist_num(NumericMatrix all_numpredictors,CharacterVector y,CharacterVector type){
    int nvar=all_numpredictors.ncol();
    int l=y.length();
    int ltype=type.length();
    List ret(nvar);
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
      sd[j]=sqrt(squre_sum[j]-count*mean[j]*mean[j])/sqrt(count-1);
    }
    result(_,0)=mean;
    result(_,1)=sd;
    ret[k] = result;
    }
    return ret;
            }')

pdist_num(as.matrix(x[,3:4]),y,levels(y))


#EG: P(MEN|T)
cppFunction('List llh_cat(CharacterMatrix all_catpredictors,CharacterVector varname,CharacterVector y,int laplace=0){
   int nvar=all_catpredictors.ncol();
   List ret;
   Function f("table");

   for (int k =0; k<nvar ; k++){
   CharacterVector predictor=all_catpredictors(_,k);
   NumericMatrix table=f(y,predictor);
   NumericMatrix llh(table.nrow(),table.ncol());
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


y=newt$Survived
llh_cat(as.matrix(newt[,1:3]),colnames(newt[,1:3]),y)

ncol(1)

tapply(x[,3], y, mean, na.rm = TRUE)
tapply(x[,3], y, sd, na.rm = TRUE)
#NumericVector conprob_fun
