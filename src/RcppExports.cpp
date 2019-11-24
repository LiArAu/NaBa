// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// llh_cat
List llh_cat(CharacterMatrix all_catpredictors, CharacterVector varname, CharacterVector y, int laplace);
RcppExport SEXP _NaBa_llh_cat(SEXP all_catpredictorsSEXP, SEXP varnameSEXP, SEXP ySEXP, SEXP laplaceSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< CharacterMatrix >::type all_catpredictors(all_catpredictorsSEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type varname(varnameSEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< int >::type laplace(laplaceSEXP);
    rcpp_result_gen = Rcpp::wrap(llh_cat(all_catpredictors, varname, y, laplace));
    return rcpp_result_gen;
END_RCPP
}
// pdist_num
List pdist_num(NumericMatrix all_numpredictors, CharacterVector varname, CharacterVector y, CharacterVector type);
RcppExport SEXP _NaBa_pdist_num(SEXP all_numpredictorsSEXP, SEXP varnameSEXP, SEXP ySEXP, SEXP typeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type all_numpredictors(all_numpredictorsSEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type varname(varnameSEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type type(typeSEXP);
    rcpp_result_gen = Rcpp::wrap(pdist_num(all_numpredictors, varname, y, type));
    return rcpp_result_gen;
END_RCPP
}
// prob_cat
List prob_cat(int ly, CharacterVector ty, CharacterMatrix newdata, List table);
RcppExport SEXP _NaBa_prob_cat(SEXP lySEXP, SEXP tySEXP, SEXP newdataSEXP, SEXP tableSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type ly(lySEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type ty(tySEXP);
    Rcpp::traits::input_parameter< CharacterMatrix >::type newdata(newdataSEXP);
    Rcpp::traits::input_parameter< List >::type table(tableSEXP);
    rcpp_result_gen = Rcpp::wrap(prob_cat(ly, ty, newdata, table));
    return rcpp_result_gen;
END_RCPP
}
// prob_num
List prob_num(int ly, CharacterVector ty, NumericMatrix newdata, List table, double eps, double threshold);
RcppExport SEXP _NaBa_prob_num(SEXP lySEXP, SEXP tySEXP, SEXP newdataSEXP, SEXP tableSEXP, SEXP epsSEXP, SEXP thresholdSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type ly(lySEXP);
    Rcpp::traits::input_parameter< CharacterVector >::type ty(tySEXP);
    Rcpp::traits::input_parameter< NumericMatrix >::type newdata(newdataSEXP);
    Rcpp::traits::input_parameter< List >::type table(tableSEXP);
    Rcpp::traits::input_parameter< double >::type eps(epsSEXP);
    Rcpp::traits::input_parameter< double >::type threshold(thresholdSEXP);
    rcpp_result_gen = Rcpp::wrap(prob_num(ly, ty, newdata, table, eps, threshold));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_NaBa_llh_cat", (DL_FUNC) &_NaBa_llh_cat, 4},
    {"_NaBa_pdist_num", (DL_FUNC) &_NaBa_pdist_num, 4},
    {"_NaBa_prob_cat", (DL_FUNC) &_NaBa_prob_cat, 4},
    {"_NaBa_prob_num", (DL_FUNC) &_NaBa_prob_num, 6},
    {NULL, NULL, 0}
};

RcppExport void R_init_NaBa(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
