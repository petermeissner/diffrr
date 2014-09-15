#' Similarity Default
#'
similarityDefault <- function(textLine1="", textLine2=""){
  compare <- function(){
    set.seed(nchar(textLine1)+nchar(textLine2))
    return( runif(n=1, min=0, max=1) )
  }
  sim <- compare()
  return( sim )
}
