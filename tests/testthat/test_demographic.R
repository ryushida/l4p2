test_that("population", {
  results <- population("Switzerland")
  expect_equal(colnames(results), c("Year", "Population"))
})
