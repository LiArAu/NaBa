
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NaBa

[![Travis build
status](https://travis-ci.org/LiArAu/NaBa.svg?branch=master)](https://travis-ci.org/LiArAu/NaBa)
[![Codecov test
coverage](https://codecov.io/gh/LiArAu/NaBa/branch/master/graph/badge.svg)](https://codecov.io/gh/LiArAu/NaBa?branch=master)

## Overview

NaBa is a machine learning classifier using naive Bayes algorithm,
providing you a simple way to make predication for a new entry based on
historical data:

  - `Info_prior()` gives you several outputs summarizing the prior
    information.

  - `predict_naBa()` calculates probablity of having each response.

You can learn more about them in `vignette("NaBa")`.

## Installation

``` r
# Install the package from Github
devtools::install_github("LiArAu/NaBa")
```

## Usage

``` r
library(NaBa)
#> 
#> Attaching package: 'NaBa'
#> The following object is masked from 'package:datasets':
#> 
#>     Titanic
x=mood[,1:5]
y=mood[,6]
newdata=mood[1:20,1:5]
prior=NaBa::Info_prior(x,y)
prior
#> $apriori
#> y
#>       bad excellent        ok 
#>    0.3335    0.3430    0.3235 
#> 
#> $tables
#> $tables$age
#>          [,1]     [,2]
#> [1,] 21.62458 2.283928
#> [2,] 21.38953 2.242398
#> [3,] 21.46555 2.372700
#> 
#> $tables$sex
#>         Female      Male
#> [1,] 0.5050167 0.4949833
#> [2,] 0.5104000 0.4896000
#> [3,] 0.4904679 0.5095321
#> 
#> $tables$gpa
#>          [,1]      [,2]
#> [1,] 3.020799 0.6033103
#> [2,] 2.993109 0.5873197
#> [3,] 3.024696 0.6054763
#> 
#> $tables$exercise
#>       Everyday     Often    Seldom
#> [1,] 0.3067993 0.3880597 0.3051410
#> [2,] 0.3470395 0.2976974 0.3552632
#> [3,] 0.3480475 0.3073005 0.3446520
#> 
#> $tables$local
#>          FALSE      TRUE
#> [1,] 0.5124378 0.4875622
#> [2,] 0.4800664 0.5199336
#> [3,] 0.4941176 0.5058824
#> 
#> 
#> $numvar_names
#> [1] "age" "gpa"
#> 
#> $catvar_names
#> [1] "sex"      "exercise" "local"   
#> 
#> $var_names
#> [1] "age"      "sex"      "gpa"      "exercise" "local"
NaBa::predict_naBa(prior,newdata,"raw")
#>             bad excellent        ok
#>  [1,] 0.3170860 0.3427901 0.3401239
#>  [2,] 0.3073673 0.3492241 0.3434086
#>  [3,] 0.3908655 0.3275820 0.2815525
#>  [4,] 0.3069837 0.3758304 0.3171859
#>  [5,] 0.2940910 0.3685839 0.3373251
#>  [6,] 0.3679443 0.3216617 0.3103940
#>  [7,] 0.3066458 0.3474369 0.3459173
#>  [8,] 0.2990142 0.3691500 0.3318359
#>  [9,] 0.4137035 0.3026918 0.2836047
#> [10,] 0.3918344 0.3148367 0.2933289
#> [11,] 0.4131870 0.2831311 0.3036819
#> [12,] 0.3907407 0.3095477 0.2997116
#> [13,] 0.3405556 0.3055009 0.3539435
#> [14,] 0.3559874 0.3129160 0.3310967
#> [15,] 0.3694203 0.3353948 0.2951849
#> [16,] 0.3800776 0.3069247 0.3129977
#> [17,] 0.3353910 0.3436690 0.3209400
#> [18,] 0.2913806 0.3758148 0.3328046
#> [19,] 0.2897601 0.3874806 0.3227593
#> [20,] 0.3007679 0.3425529 0.3566792
NaBa::predict_naBa(prior,newdata,"class")
#>  [1] excellent excellent bad       excellent excellent bad       excellent
#>  [8] excellent bad       bad       bad       bad       ok        bad      
#> [15] bad       bad       excellent excellent excellent ok       
#> Levels: bad excellent ok
```

## Getting help

If you encounter a clear bug, please file a minimal reproducible example
on [github](https://github.com/LiArAu/NaBa). For questions and other
discussion, please send email to the
[maintainer](mailto:yajingli@umich.edu).
