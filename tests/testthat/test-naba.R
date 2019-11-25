test_that("predict_naBa works", {
  data(mood)
  x=mood[,1:5]
  y=mood[,6]
  newdata=mood[1:10,1:5]
  prior=NaBa::Info_prior(x,y)
  expect_equal(predict_naBa(prior,newdata,"class"), factor(c("excellent",
  "excellent","bad","excellent","excellent","bad","excellent","excellent","bad","bad")))
})
