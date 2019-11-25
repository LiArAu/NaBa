test_that("predict_naBa works", {
  set.seed(101)
  n=20
  mood=data.frame(age=sample(seq(18,25),n,replace=T),
                  sex=sample(c("Female","Male"),n,replace=T),
                  gpa=sample(seq(2,4,0.1),n,replace=T),
                  exercise=sample(c("Everyday","Often","Seldom"),n,replace=T),
                  local=sample(c("TRUE","FALSE"),n,replace=T),
                  mood=sample(c("bad","ok","excellent"),n,replace=T))
  test.na=mood
  test.na$age[sample.int(n,n/10,replace = F)]=NA
  test.na$sex[sample.int(n,n/10,replace = F)]=NA
  test.na$gpa[sample.int(n,n/10,replace = F)]=NA
  test.na$exercise[sample.int(n,n/10,replace = F)]=NA
  test.na$local[sample.int(n,n/10,replace = F)]=NA
  x=test.na[1:(3/4*n),1:5]
  y=test.na[1:(3/4*n),6]
  newdata=test.na[(3/4*n+1):n,1:5]
  prior=NaBa::Info_prior(x,y)
  expect_equal(predict_naBa(prior,newdata,"class"), factor(c("bad","bad","bad","excellent","excellent")))
})
