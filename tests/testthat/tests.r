context("Similarity Function Testing")

test_that("similarityDefault is working as expected", {
  sim <- similarityDefault
  expect_true(sim()>=0)
  expect_true(sim(10,12445)>=0)
  expect_true(sim("asdsadfd","a")>=0)
  expect_true(sim("","")>=0)
  expect_true(is.numeric(sim()))
})


context("Testing diffr() ")

test_that("diffr runs with the two example texts", {
  res <- diffr(text1, text2)
  expect_true( is.character(res$text1_orig) )
  expect_true( is.character(res$text2_orig) )
  expect_true( is.character(res$text1_clean) )
  expect_true( is.character(res$text2_clean) )
  expect_true( is.matrix(res$alignment_auto) )
  expect_true( is.matrix(res$alignment_semi) )
  expect_true( is.matrix(res$distance_veca) )
  expect_true( is.matrix(res$distance_vecs) )
  expect_true( is.matrix(res$distance_matrix) )
})



