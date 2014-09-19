#' A function for aligning text and measuring its distance.
#'
#' @aliases textAlign
#'
#' @param text1 first text; expected to be a character vector; each vector
#'   element of text1 will be compared to each element of text2
#' @param text2 see text1
#'
#'   (\code{file=FALSE}) or as file path (the default with \code{file=TRUE}).
#' @param clean The function to be applied to each line of the text prior to
#'   alignment and difference measurement.
#'
#' @return The function returns a list with items: \itemize{ \item
#'   \code{text1_orig} and \code{text2_orig} holding the original texts, \item
#'   \code{text1_clean} and \code{text2_clean} holding the texts after cleaning,
#'   \item \code{alignment_auto} and \code{alignment_semi} data frames holding
#'   the corresponding line numbers from \code{text1} and \code{text2} and the
#'   distance between them \item \code{distance_matrix} a matrix of distances
#'   between text lines -- rows for text1 and columns for text2 }
#'
#' @examples
#' require(stringr)
#' diffr(str_split(exampleA1,"\n"), str_split(exampleA2,"\n"))


diffr <- function(text1, text2, clean="none", dist="levenshtein"){

  # input checking
    # text supplied as character vector?
     if( class(text1)=="list" & class(text2)=="list" ){
      text1 <- unlist(text1)
      text2 <- unlist(text2)
     }
     if( class(text1)!="character" | class(text2)!="character" ){
      stop("Class of texts supplied should be character.")
     }
    # Clean Text Functions: either supplied or selected from defaults
      if(class(clean)=="character" ){
        if( !(clean %in% names(cleanTextFunctions)) ){
          stop(paste("No such function as '",clean,"' to be found"))
        }
        clean <- cleanTextFunctions[[clean]]
      }
      if( class(clean)!= "function"){
        stop("clean argument supplied is neither one of
             the package defaults nor a valid function.")
      }
      text1_clean <- clean(text1)
      text2_clean <- clean(text2)
    # Clean Text Functions: either supplied or selected from defaults
      if(class(dist)=="character" ){
        if( !(dist %in% names(distanceFunctions)) ){
          stop(paste("No such function as '",dist,"' to be found"))
        }
        dist <- distanceFunctions[[dist]]
      }
      if( class(dist)!= "function"){
        stop("clean argument supplied is neither one of
               the package defaults nor a valid function.")
      }

  # distance calculation
    distance_matrix <- dist(text1_clean, text2_clean)

  # text alignment

  # results preparation
  res <- list( text1_orig=text1,
               text2_orig=text2,
               text1_clean=text1_clean,
               text2_clean=text2_clean,
               alignment_auto  = cbind( c(1,2,3), c(1,2,3) ),
               alignment_semi  = cbind( c(1,2,3,3), c(1,2,3,4) ),
               distance_vauto  = c(0,1,0),
               distance_vsemi  = c(0,1,0,1),
               distance_matrix = distance_matrix
             )
  # return
  invisible(res)
 }

















