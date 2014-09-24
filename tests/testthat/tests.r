

context("Testing: diffr() ")

test_that("diffr runs with the two example texts
          and results in plausible return", {
  res <- diffr(example_A1_split, example_A2_split)
  expect_true( is.character(res$text1_orig) )
  expect_true( is.character(res$text2_orig) )
  expect_true( is.character(res$text1_clean) )
  expect_true( is.character(res$text2_clean) )
  expect_true( is.data.frame(res$alignment_df) )
  expect_true( is.matrix(res$distance_matrix) )
})

test_that("diffr runs with all distFunctions", {
  t1 <- example_A1_split
  t2 <- example_A2_split

  for ( i in seq_along(distanceFunctions) )
  res <- diffr(t1, t2, dist=distanceFunctions[[i]] )$alignment_df
    expect_true( is.data.frame(res) )

})

test_that("diffr runs with all cleanTextFunctions", {
  t1 <- example_A1_split
  t2 <- example_A2_split

  for ( i in seq_along(cleanTextFunctions) )
    res <- diffr(t1, t2, clean=cleanTextFunctions[[i]] )$alignment_df
  expect_true( is.data.frame(res) )
})


context("Testing: cleanTextFunctions")

  test_that("cleanText Functions work", {
    ctf <- names(cleanTextFunctions)
    for(i in seq_along(ctf)){
      expect_is(cleanTextFunctions[[ctf[i]]], "function")
      res <- diffr(example_A1_split, example_A2_split, ctf[i])
      expect_is(res, "list")
    }
  })


context("Testing: distanceFunctions")

test_that("Similarity Functions work??", {
  distf <- names(distanceFunctions)
  for(i in seq_along(distf)){
    expect_is(distanceFunctions[[ distf[i] ]], "function")
    res <- distanceFunctions[[ distf[i] ]](example_A1_split, example_A2_split)
    expect_true(class(res) %in% c("matrix","numeric"))
  }
})


context("Testing: text_align()")

test_that("does choose_maxdist_option work with reasonable input?", {
  res <- distanceFunctions$levenshtein(example_A1_split, example_A2_split)
  expect_is(.choose_maxdist_option(res, "auto"),"numeric")
  expect_is(.choose_maxdist_option(res, "Inf") ,"numeric")
  expect_is(.choose_maxdist_option(res, "inf") ,"numeric")
  expect_is(.choose_maxdist_option(res, "10%") ,"numeric")
  expect_is(.choose_maxdist_option(res, "100%") ,"numeric")
  expect_is(.choose_maxdist_option(res, "99.999999991%") ,"numeric")
  expect_is(.choose_maxdist_option(res, "0.00000000001%") ,"numeric")
  expect_is(.choose_maxdist_option(res, 100000000) ,"numeric")
  expect_is(.choose_maxdist_option(res, 0) ,"numeric")
})

test_that("text align does work with reasonable input", {
  res <- distanceFunctions$levenshtein(example_A1_split, example_A2_split)
  expect_is(text_align(res),"matrix")
  expect_is(text_align(res, "auto"),"matrix")
  expect_is(text_align(res, retMatrix=F),"data.frame")
})


















