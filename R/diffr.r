#' A function for aligning text and measuring its distance.
#'
#' @aliases text_align, example_A1, example_A2, example_A1_split,
#'   example_A2_split
#'
#' @param text1 first text; expected to be a character vector; each vector
#'   element of text1 will be compared to each element of text2
#' @param text2 see text1
#'
#'   (\code{file=FALSE}) or as file path (the default with \code{file=TRUE}).
#' @param clean The function to be applied to each line of the text prior to
#'   alignment and difference measurement.
#'
#' @param dist the name of one of the distance functions provided by the package
#'   or a user made function to be use instead. Such a function would be
#'   expected to take two texts as argument and return a distance matrix wit
#'   rows referring to the first text and columns referring to the second text.
#'   To get an overview over the distance functions provided at the moment use:
#'   \code{names(distanceFunctions)}
#'
#' @param maxdiff TOBEWRITTEN
#'
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
#' ## diffr(example_A1_split, example_A2_split)


diffr <- function(text1, text2, clean="none",
                  dist="levenshtein", maxDist="Inf",
                  ret="all"){

  # text supplied as character vector?
   if( class(text1)=="list" & class(text2)=="list" ){
    text1 <- unlist(text1)
    text2 <- unlist(text2)
   }
   if( class(text1)!="character" | class(text2)!="character" ){
    stop("Class of texts supplied should be character.")
   }

  # Clean Text Functions: either supplied or selected from defaults
    # 1 checking
    # 2 selecting/asigning
    # 3 calculation
    if(class(clean)=="character" ){
      if( !(clean %in% names(cleanTextFunctions)) ){
        stop(paste("No such function as '",clean,"' to be found. Check out names(cleanTextFunctions)"))
      }
      clean <- cleanTextFunctions[[clean]]
    }
    if( class(clean)!= "function"){
      stop("clean argument supplied is neither one of
           the package defaults nor a valid function.")
    }
    text1_clean <- clean(text1)
    text2_clean <- clean(text2)

  # Distance Function: either supplied or selected from defaults
    # 1 checking
    # 2 selecting/asigning
    # 3 calculation
    if(class(dist)=="character" ){
      if( !(dist %in% names(distanceFunctions)) ){
        stop(paste("No such function as '",dist,"' to be found.  Check out names(distanceFunctions)"))
      }
      dist <- distanceFunctions[[dist]]
    }
    if( class(dist)!= "function"){
      stop("clean argument supplied is neither one of
             the package defaults nor a valid function.")
    }
    distance_matrix  <- dist(text1_clean, text2_clean)
    text1_indel_dist <- as.vector(dist(text1_clean, ""))
    text2_indel_dist <- as.vector(dist(text2_clean, ""))

  # text alignment
  AlignM  <- text_align(distance_matrix, maxDist, T)
  AlignDF <- align_matrix_to_align_df(AlignM,
                                      distance_matrix,
                                      text1_indel_dist,
                                      text2_indel_dist)


  # results preparation
  res <- list( text1_orig        = text1,
               text2_orig        = text2,
               text1_clean       = text1_clean,
               text2_clean       = text2_clean,
               distance_matrix   = distance_matrix,
               alignment_df      = AlignDF
  )
  # return
  if ( all(ret == "all") ) {
    return(res)
  }
  if ( all(ret == "default") ) {
    return(res$alignment_auto)
  }
  if ( length(ret)>1 ){
    return(res[ret])
  }
 }

















