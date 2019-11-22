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
  x.num=as.matrix(x[,sapply(x[1,],is.numeric)])
  x.cat=as.matrix(x[,!sapply(x[1,],is.numeric)])

  #when only one numeric predictor or categorical predictor
  colnames(x.num)=colnames(x)[sapply(x[1,],is.numeric)]
  colnames(x.cat)=colnames(x)[!sapply(x[1,],is.numeric)]
  apriori <- table(y)/length(y)
  if (ncol(x.num)==0){
    numvar_tables=NA
    catvar_tables=llh_cat(x.cat,colnames(x.cat),y,laplace)
  }
  else if (ncol(x.cat)==0){
    catvar_tables=NA
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


