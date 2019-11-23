#' Predict outcome of new data
#'
#' You can use `Predict_naBa` with any data frame.
#'
#' @param prior Prior information. (output of Info_prior())
#' @param ppd_data Prepared newdata with the same format as prior dataset. (Output of prep())
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
#' ppd_data=prep(prior,newdata)
#' myresult=predict_naBa(prior,ppd_data,"raw")

predict_naBa=function(prior,ppd_data, type = c("class", "raw"),eps=0,threshold=0.001){
  source("~/NaBa/R/Rcpp_predict.R")
  ny=length(prior$apriori)
  newdata=ppd_data$new
  newdata_num=as.matrix(newdata[,ppd_data$num_var])
  newdata_cat=as.matrix(newdata[,ppd_data$cat_var])
  if (length(ppd_data$num_var)==0){
    prob.cat=prob_cat(ny,newdata_cat,prior$catvar_conpro,one_ob_prob_cat)
    numerator=t(prob.cat)}
  else if (length(ppd_data$cat_var)==0){
    prob.num=prob_num(ny,newdata_num,prior$numvar_dist,one_ob_prob_num)
    numerator=t(prob.num)}
  else{
    prob.cat=prob_cat(ny,newdata_cat,prior$catvar_conpro,one_ob_prob_cat)
    prob.num=prob_num(ny,newdata_num,prior$numvar_dist,one_ob_prob_num)
    numerator=t(prob.num+prob.cat)}
  if (type == "class"){
    output=as.factor(names(prior$apriori)[apply(numerator, 1, which.max)])}
  else {
    numerator=numerator+t(matrix(log(prior$apriori),ny,nrow(newdata)))
    output=sapply(1:ny,function(y){ 1/rowSums(exp(numerator - numerator[,y]))})}
  return (output)
}

#' @export
#' @rdname predict.naBa



