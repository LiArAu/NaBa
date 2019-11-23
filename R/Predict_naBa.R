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
  one_ob_prob_num=function(y_len,newdata_num,table,eps=0,threshold=0.001){
    prob=matrix(nrow=y_len,ncol=length(newdata_num))
    for (j in 1:length(newdata_num)){
      x_prior=table[[j]]
      x_prior[x_prior[, 2]<=eps, 2]=threshold
      if (is.na(newdata_num[j])){ prob[,j]=1}
      else{
        prob[,j]=dnorm(newdata_num[j],x_prior[,1],x_prior[,2],FALSE)
        prob[prob[,j] <= eps,j]=threshold}}
    return (rowSums(log(prob)))}

  cppFunction('NumericMatrix prob_num(int y_len,NumericMatrix newdata,List table,Function f, double eps=0, double threshold=0.001){
    int entry=newdata.nrow();
    NumericMatrix all_prob(y_len,entry);
    for (int j =0; j<entry; j++){
      NumericVector nd=newdata(j,_);
      NumericVector temp=f(y_len,nd,table,eps,threshold);
      for (int i =0; i<y_len; i++){
         all_prob(i,j)=temp[i];}}
    return all_prob;}')

  one_ob_prob_cat=function(table,y_len,newdata_cat,eps=0,threshold=0.001){
    prob=matrix(nrow=y_len,ncol=length(newdata_cat))
    for (j in 1:length(newdata_cat)){
      if (is.na(newdata_cat[j])){ prob[,j]=1 }
      else{
        prob[,j]=table[[j]][,newdata_cat[j]]
        prob[prob[,j] <= eps,j]=threshold}}
    return (rowSums(log(prob)))}


  cppFunction('NumericMatrix prob_cat(int y_len,CharacterMatrix newdata,List table,Function f){
    int entry=newdata.nrow();
    NumericMatrix all_prob(y_len,entry);
    for (int j =0; j<entry; j++){
      CharacterVector nd=newdata(j,_);
      NumericVector temp=f(table,y_len,nd);
      for (int i =0; i<y_len; i++){
         all_prob(i,j)=temp[i];
      }
    }
    return all_prob;
            }')

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

    numerator=numerator+t(matrix(log(prior$apriori),ny,nrow(newdata)))
    output=sapply(1:ny,function(y){ 1/rowSums(exp(numerator - numerator[,y]))})
  if (type == "class"){
    output=as.factor(names(prior$apriori)[apply(output, 1, which.max)])}
  else {
    colnames(output)=names(prior$apriori)}
  return (output)
}

#' @export
#' @rdname predict.naBa



