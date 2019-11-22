L <- log(object$apriori) + apply(log(sapply(seq_along(attribs),
                                            function(v) {
                                              nd <- ndata[attribs[v]]
                                              if (is.na(nd)) rep(1, length(object$apriori))
                                              else {
                                                prob <-
                                                  if (isnumeric[attribs[v]]) {
                                                  msd <- object$tables[[v]]
                                                  msd[, 2][msd[, 2] <= eps] <- threshold
                                                  dnorm(nd, msd[, 1], msd[, 2])
                                                }
                                                else object$tables[[v]][, nd + islogical[attribs[v]]]

                                                prob[prob <= eps] <- threshold
                                                prob
                                              }
                                            })), 1, sum)
