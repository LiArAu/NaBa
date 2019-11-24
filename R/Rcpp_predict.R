library(Rcpp)
cppFunction('List prob_cat(int ly,CharacterVector ty,CharacterMatrix newdata,List table){
  int entry=newdata.nrow();
  int lx=newdata.ncol();
  List all_prob;
  Function R_match("match");

  for (int i =0; i<ly; i++){
    NumericMatrix prob_y(entry,lx);
    for (int k =0; k<lx; k++){
      NumericMatrix x_prior=table[k];
      NumericVector m=x_prior(i,_);
      for (int j =0; j<entry; j++){
        String temp=newdata(j,k);
        NumericVector pos = R_match(temp,colnames(m));
        int pos1=pos[0]-1;
        prob_y(j,k)=m[pos1];}}
    String name=ty[i];
    all_prob[name]=prob_y;
  }
  return all_prob;
}')

#prob_cat(3,levels(y),as.matrix(newdata_cat),prior$tables[prior$catvar_names])

cppFunction('List prob_num(int ly,CharacterVector ty,NumericMatrix newdata,List table, double eps=0, double threshold=0.001){
  int entry=newdata.nrow();
  int lx=newdata.ncol();
  List all_prob;

  for (int i =0; i<ly; i++){
    NumericMatrix prob_y(entry,lx);
    for (int k =0; k<lx; k++){
      NumericMatrix x_prior=table[k];
      double m=x_prior(i,0);
      double v=x_prior(i,1);
      prob_y(_,k)=dnorm(newdata(_,k),m,v,false);
    }
    String name=ty[i];
    all_prob[name]=prob_y;
  }
  return all_prob;
}')

#prob_num(3,levels(y),newdata_num,prior$tables[prior$numvar_names])



