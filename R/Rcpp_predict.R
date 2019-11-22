library(Rcpp)
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





