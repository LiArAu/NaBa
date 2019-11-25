#' Using prior information to calculate distribution of responses and
#' conditional probability of predictors given certain reponse.
#'
#' You can use `Info_prior` with any data frame.
#'
#' @param x Prior information of predictors.
#' @param y Prior information of responses.
#' @param laplace A small correction to smooth categorical data.
#' @return  `apriori`: Distribution of responses.
#' @return  `numvar_dist`: A list of distribution (mean and variance) of numeric predictors.
#' @return  `catvar_conpro`: A list of conditional probability of categorical predictors.
#' @return  `var_names`: Names of all predictors.
#' @export
#' @examples
#' data(mood)
#' n=2000
#' x=mood[1:(3/4*n),1:5]
#' y=mood[1:(3/4*n),6]
#' prior=Info_prior(x,y)  #Laplace=0 as default
#' prior

Info_prior=function(x,y,laplace=0){
  x.num=as.matrix(x[,sapply(x[1,],is.numeric)])
  x.cat=as.matrix(x[,!sapply(x[1,],is.numeric)])
  #in case only one numeric predictor or categorical predictor
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
    catvar_tables=llh_cat(x.cat,colnames(x.cat),y,0)
  }
  tables = c(numvar_tables,catvar_tables)
  attribs=match(colnames(x), names(tables))
  tables=tables[attribs]
  return (list(apriori = apriori,
               tables = tables,
               numvar_names=colnames(x.num),
               catvar_names=colnames(x.cat),
               var_names=colnames(x)))
}

#' @export
#' @rdname Info_prior


