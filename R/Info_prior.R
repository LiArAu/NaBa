#' Using prior information to calculate distribution of responses and
#' conditional probability of predictors given certain reponse.
#'
#' You can use `Info_prior` with any data frame without any NA in it.
#'
#' @param x Prior information of predictors.
#' @param y Prior information of responses.
#' @param laplace A small correction to smooth categorical data.
#' @return
#'   `apriori`: Distribution of responses.
#'   `numvar_dist`: A list of distribution (mean and variance) of numeric predictors.
#'   `catvar_conpro`: A list of conditional probability of categorical predictors.
#'   `var_names`: Names of all predictors.
#' @export
#' @examples
#' iris=as.data.frame(iris)
#' x=iris[,1:4]
#' y=iris[,5]
#'
#' # Make sure there is no missing data in your dataset before putting them in the function,
#'   you may impute your data or simply remove observations with NA.
#' # Make sure y is a factor.
#' prior=Info_prior(x,y)  #Laplace=0 as default
#' prior

Info_prior=function(x,y,laplace=0){
  cppFunction('List pdist_num(NumericMatrix all_numpredictors,CharacterVector varname,CharacterVector y,CharacterVector type){
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

  x.num=as.matrix(x[,sapply(x[1,],is.numeric)])
  x.cat=as.matrix(x[,!sapply(x[1,],is.numeric)])

  #when only one numeric predictor or categorical predictor
  colnames(x.num)=colnames(x)[sapply(x[1,],is.numeric)]
  colnames(x.cat)=colnames(x)[!sapply(x[1,],is.numeric)]
  apriori <- table(y)/length(y)
  if (ncol(x.num)==0){
    numvar_tables=NULL
    catvar_tables=llh_cat(x.cat,colnames(x.cat),y,laplace)
  }
  else if (ncol(x.cat)==0){
    catvar_tables=NULL
    numvar_tables=pdist_num(x.num,colnames(x.num),y,levels(y))
  }
  else{
    numvar_tables=pdist_num(x.num,colnames(x.num),y,levels(y))
    catvar_tables=llh_cat(x.cat,colnames(x.cat),y,laplace)
  }
  return (list(apriori = apriori,
               numvar_dist = numvar_tables,
               catvar_conpro = catvar_tables,
               var_names=colnames(x)))
}

#' @export
#' @rdname Info_prior


