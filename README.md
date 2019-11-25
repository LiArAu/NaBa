# NaBa R Package

  <!-- badges: start -->
  [![Travis build status](https://travis-ci.org/LiArAu/NaBa.svg?branch=master)](https://travis-ci.org/LiArAu/NaBa)
  [![Codecov test coverage](https://codecov.io/gh/LiArAu/NaBa/branch/master/graph/badge.svg)](https://codecov.io/gh/LiArAu/NaBa?branch=master)
  <!-- badges: end -->

## Overview

NaBa is a machine learning classifier using naive Bayes algorithm, providing you a simple way to make predication for a new entry based on historical data:

* `Info_prior()` gives you several outputs summarizing the prior information.

* `predict_naBa()` calculates probablity of having each response.

## Installation

```{r, eval = FALSE}
# Install the package from Github
devtools::install_github("LiArAu/NaBa")
```

## Usage

```{r,echo=FALSE}
library(NaBa)
data(mood)
x=mood[,1:5]
y=mood[,6]
newdata=mood[1:200,1:5]
NaBa::Info_prior(x,y)
NaBa::predict_naBa(prior,newdata,"raw")
NaBa::predict_naBa(prior,newdata,"class")
```

## Getting help

If you encounter a clear bug, please file a minimal reproducible example on [github](https://github.com/LiArAu/NaBa). For questions and other discussion, please send email to the [maintainer](mailto:yajingli@umich.edu).

