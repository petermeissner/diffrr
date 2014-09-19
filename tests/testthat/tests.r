
context("Testing diffr() ")

  test_that("diffr runs with the two example texts and results in plausible return", {
    res <- diffr(example_A1_split, example_A2_split)
    expect_true( is.character(res$text1_orig) )
    expect_true( is.character(res$text2_orig) )
    expect_true( is.character(res$text1_clean) )
    expect_true( is.character(res$text2_clean) )
    expect_true( is.matrix(res$alignment_auto) )
    expect_true( is.matrix(res$alignment_semi) )
    expect_true( is.vector(res$distance_vauto) )
    expect_true( is.vector(res$distance_vsemi) )
    expect_true( is.matrix(res$distance_matrix) )
    expect_true( length(res$distance_vauto) == length(res$alignment_auto[,1]) )
    expect_true( length(res$distance_vsemi) == length(res$alignment_semi[,1]) )
  })


context("Testing cleanText Functions ")

  test_that("cleanText Functions work", {
    ctf <- names(cleanTextFunctions)
    for(i in seq_along(ctf)){
      expect_is(cleanTextFunctions[[ctf[i]]], "function")
      res <- diffr(example_A1_split, example_A2_split, ctf[i])
      expect_is(res, "list")
    }
  })


context("Testing Similarity Functions ")

test_that("Similarity Functions work??", {
  distf <- names(distanceFunctions)
  for(i in seq_along(distf)){
    expect_is(distanceFunctions[[ distf[i] ]], "function")
    res <- distanceFunctions[[ distf[i] ]](example_A1_split, example_A2_split)
    expect_true(class(res) %in% c("matrix","numeric"))
  }
})




