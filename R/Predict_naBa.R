#' Predict outcome of new data
#'
#' You can use `Predict_naBa` with any data frame.
#'
#' @param prior Prior information. (output of Info_prior())
#' @param newdata with the same format as prior dataset. (Output of prep())
#' @param type Type of outcome you want: "Class" prediction or "Raw" probabilities.
#' @param eps A small number to specify an epsilon-range for Laplace smoothing; default=0.
#' @param threshold Replace cells value under epsilon range with threshold; default=0.001.
#' @return
#'   `output`: A vector of predicted classes if type="class";
#'   A matrix of conditional probabilities if type="raw".
#' @export
#' @examples
#' iris=as.data.frame(iris)
#' x=iris[,1:4]
#' y=iris[,5]
#' prior=Info_prior(x,y)  #Laplace=0 as default
#' myresult=predict_naBa(prior,newdata,"raw")

predict_naBa=function(prior,newdata, type = c("class", "raw"),eps=0,threshold=0.001){
  newdata=as.data.frame(newdata)
  ## fix factor variables to be identical with training data
  attribs <- match(prior$var_names, names(newdata))
  ppd_data=data.frame(matrix(nrow=nrow(newdata),ncol=length(attribs)))
  not_na=which(!is.na(attribs))
  ppd_data[,not_na]=newdata[,attribs[not_na]]
  colnames(ppd_data)=prior$var_names
  ny=length(prior$apriori)
  newdata=ppd_data
  num_var=prior$numvar_names
  cat_var=prior$catvar_names

  if (length(num_var)==0){
    newdata_cat=as.matrix(newdata[,cat_var])
    prob.cat=prob_cat(length(prior$apriori),names(prior$apriori),newdata_cat,prior$tables[colnames(newdata_cat)])
    prob.cat=lapply(prob.cat,function(x) {
      apply(x,2,function(a){
        a[a<=eps]=threshold
        a=log(a)
        return (a)})})
    numerator=as.data.frame(lapply(prob.cat,rowSums))}
  else if (length(cat_var)==0){
    newdata_num=as.matrix(newdata[,num_var])
    prob.num=prob_num(length(prior$apriori),names(prior$apriori),newdata_num,prior$tables[colnames(newdata_num)])
    prob.num=lapply(prob.num,function(x) {
      apply(x,2,function(a){
        a[a==0]=1
        a[a<=eps]=threshold
        a=log(a)
        return (a)})})
    numerator=as.data.frame(lapply(prob.num,rowSums))}
  else{
    newdata_num=as.matrix(newdata[,num_var])
    newdata_cat=as.matrix(newdata[,cat_var])
    prob.cat=prob_cat(length(prior$apriori),names(prior$apriori),newdata_cat,prior$tables[colnames(newdata_cat)])
    prob.num=prob_num(length(prior$apriori),names(prior$apriori),newdata_num,prior$tables[colnames(newdata_num)])
    prob.cat=lapply(prob.cat,function(x) {
      apply(x,2,function(a){
        a[a<=eps]=threshold
        a=log(a)
        return (a)})})
    prob.num=lapply(prob.num,function(x) {
      apply(x,2,function(a){
        a[a==0]=1
        a[a<=eps]=threshold
        a=log(a)
        return (a)})})
    foo <- function(x, y) {list(x+y)}
    numerator=as.data.frame(mapply(foo, lapply(prob.cat,rowSums), lapply(prob.num,rowSums)))
    }
  numerator=numerator+t(matrix(log(prior$apriori),ny,nrow(newdata)))
  output=sapply(1:ny,function(y){ 1/rowSums(exp(numerator - numerator[,y]))})
  if (type == "class"){output=as.factor(names(prior$apriori)[apply(output, 1, which.max)])}
  else {colnames(output)=names(prior$apriori)}
  return (output)
}

#' @export
#' @rdname predict.naBa



