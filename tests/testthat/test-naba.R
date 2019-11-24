test_that("predict_naBa works", {
  expect_equal(predict_naBa(prior,newdata,"raw"), predict(prior2,newdata,"raw"))
  expect_equal(predict_naBa(prior,newdata,"class"), predict(prior2,newdata,"class"))
})
