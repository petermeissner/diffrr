context("Similarity Function Testing")

test_that("similarityDefault is working as expected", {
  sim <- similarityDefault
  expect_true(sim()>=0)
  expect_true(sim(10,12445)>=0)
  expect_true(sim("asdsadfd","a")>=0)
  expect_true(sim("","")>=0)
  expect_true(is.numeric(sim()))
})


context("Cleaning Function Working")

test_that("similarityDefault is working as expected", {
  sim <- similarityDefault
  expect_true(sim()>=0)
  expect_true(sim(10,12445)>=0)
  expect_true(sim("asdsadfd","a")>=0)
  expect_true(sim("","")>=0)
  expect_true(is.numeric(sim()))
})
