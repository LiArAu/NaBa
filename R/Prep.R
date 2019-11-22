#' Prepare new data for prediction
#'
#' You can use `prep` with any data frame.
#'
#' @param prior Prior information. (output of Info_prior())
#' @param newdata New entries that you want to make predictions.
#' @return
#'   `new`: Prepared new data.
#'   `num_var`: Numeric predictors.
#'   `cat_var`: Categorical predictors.
#' @export
#' @examples
#' iris=as.data.frame(iris)
#' x=iris[,1:4]
#' y=iris[,5]
#' prior=Info_prior(x,y)  #Laplace=0 as default
#' ppd_data=prep(prior,newdata)


prep<-function(prior,newdata){
  newdata=as.data.frame(newdata)
  ## fix factor variables to be identical with training data
  attribs <- match(prior$var_names, names(newdata))
  num_var=names(prior$numvar_dist)
  cat_var=names(prior$catvar_conpro)
  new=matrix(nrow=nrow(newdata),ncol=length(attribs))
  new=data.frame(new)
  not_na=which(!is.na(attribs))
  new[,not_na]=newdata[,attribs[not_na]]
  colnames(new)=prior$var_names
  return (list(new=new,num_var=num_var,cat_var=cat_var))
}

#' @export
#' @rdname prep

