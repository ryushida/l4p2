test_that("gdp", {
  results <- gdp("Switzerland")
  expect_equal(colnames(results), c("Year", "GDP"))
})
