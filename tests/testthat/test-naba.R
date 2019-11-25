test_that("predict_naBa works", {
  data(mood)
  x=mood[,1:5]
  y=mood[,6]
  newdata=mood[1:200,1:5]
  prior=NaBa::Info_prior(x,y)
  prior2=e1071::naiveBayes(x,y)
  expect_equal(predict_naBa(prior,newdata,"class"),predict(prior2,newdata,"class"))
})

