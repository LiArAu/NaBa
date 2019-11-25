test_that("predict_naBa works", {
  data(mood)
  x=mood[,1:5]
  y=mood[,6]
  newdata=mood[1:100,1:5]
  prior=NaBa::Info_prior(x,y)
  prior2=e1071::naiveBayes(x,y)
  expect_equal(predict_naBa(prior,newdata,"class"),predict(prior2,newdata,"class"))
  expect_equal(predict_naBa(prior,newdata,"raw"),predict(prior2,newdata,"raw"))

  data(iris)
  x=iris[,1:4]
  y=iris[,5]
  newdata=iris[1:50,1:4]
  prior=NaBa::Info_prior(x,y)
  prior2=e1071::naiveBayes(x,y)
  expect_equal(matrix(predict_naBa(prior,newdata,"class")),matrix(predict(prior2,newdata,"class")))

  data(Titanic)
  x=Titanic[,1:3]
  y=Titanic[,4]
  newdata=Titanic[1:10,1:3]
  prior=NaBa::Info_prior(x,y)
  prior2=e1071::naiveBayes(x,y)
  expect_equal(predict_naBa(prior,newdata,"class"),predict(prior2,newdata,"class"))
})

