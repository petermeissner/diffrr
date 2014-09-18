#' A function for aligning text and measuring its distance.
#'
#' @aliases textAlign
#'
#' @param text1
#' first text; expected to be a character vector;
#' each vector element of text1 will be compared to each element of text2
#' @param text2
#' see text1
#'
#'  (\code{file=FALSE}) or as file path (the default with \code{file=TRUE}).
#' @param cleanText
#' The function to be applied to each line of the text prior
#' to alignment and difference measurement.
#'
#' @return The function returns a list with items:
#' \itemize{
#'   \item \code{text1_orig} and \code{text2_orig} holding the original texts,
#'   \item \code{text1_clean} and \code{text2_clean} holding the texts after cleaning,
#'   \item \code{alignment_auto} and \code{alignment_semi} data frames holding
#'   the corresponding line numbers from \code{text1} and \code{text2}
#'   and the distance between them
#'   \item \code{distance_matrix} a matrix of distances between text lines
#'   -- rows for text1 and columns for text2
#'  }
#'
#' @examples
#' require(stringr)
#' text1 = unlist(str_split(
#' "This part of the
#' document has stayed the
#' same from version to
#' version.  It shouldn't
#' be shown if it doesn't
#' change.  Otherwise, that
#' would not be helping to
#' compress the size of the
#' changes.
#'
#' This paragraph contains
#' text that is outdated.
#' It will be deleted in the
#' near future.
#'
#' It is important to spell
#' check this dokument. On
#' the other hand, a
#' misspelled word isn't
#' the end of the world.
#' Nothing in the rest of
#' this paragraph needs to
#' be changed. Things can
#' be added after it.","\n"))
#'
#' text2      = unlist(strsplit(
#' "This is an important
#' notice! It should
#' therefore be located at
#' the beginning of this
#' document!
#'
#' This part of the
#' document has stayed the
#' same from version to
#' version.  It shouldn't
#' be shown if it doesn't
#' change.  Otherwise, that
#' would not be helping to
#' compress anything.
#'
#' It is important to spell
#' check this document. On
#' the other hand, a
#' misspelled word isn't
#' the end of the world.
#' Nothing in the rest of
#' this paragraph needs to
#' be changed. Things can
#' #be added after it.
#'
#' This paragraph contains
#' important new additions
#' to this document.", "\n"))
#'
#' diffr(text1, text2)

diffr <- function(text1, text2, cleanText=cleanTextDefault){
  text1_clean <- cleanText(text1)
  text2_clean <- cleanText(text2)
  res <- list( text1_orig=text1,
               text2_orig=text2,
               text1_clean=text1_clean,
               text2_clean=text2_clean
             )
  return(res)
 }


















