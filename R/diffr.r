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


diffr <- function(text1=example_A1_split,
                  text2=example_A2_split,
                  clean="none",
                  dist="levenshtein",
                  maxDist="Inf",
                  sortDF=c(1,2,0),
                  ignore="empty",
                  ret="all"){

  # text supplied as character vector?
    if( class(text1)=="list" & class(text2)=="list" ){
      text1 <- unlist(text1)
      text2 <- unlist(text2)
    }
    if( class(text1)!="character" | class(text2)!="character" ){
      stop("Class of texts supplied should be character.")
    }

  # Ignore Lines
    ignore <- select_function_option(ignore, ignoreLinesFunctions)
    text1_ignore <- ignore(text1)
    text2_ignore <- ignore(text2)

  # Clean Text
    clean <- select_function_option(clean, cleanTextFunctions)
    text1_clean <- text1
    text2_clean <- text2
    text1_clean[!text1_ignore] <- clean(text1[!text1_ignore])
    text2_clean[!text2_ignore] <- clean(text2[!text2_ignore])

  # Distance Calculation
    dist <- select_function_option(dist, distanceFunctions)
    distance_matrix  <- dist(text1_clean, text2_clean)
    distance_matrix[text1_ignore , ] <- Inf
    distance_matrix[ , text2_ignore] <- Inf
    text1_indel_dist <- as.vector(dist(text1_clean, ""))
    text2_indel_dist <- as.vector(dist(text2_clean, ""))
    text1_indel_dist[text1_ignore] <- NA
    text2_indel_dist[text2_ignore] <- NA

  # text alignment
    alignM  <- text_align(distance_matrix, maxDist, T)
    alignDF <- align_matrix_to_align_df(alignM,
                                        distance_matrix,
                                        text1_indel_dist,
                                        text2_indel_dist)
    if(sortDF[1] == 0){
      alignDF <- alignDF[ order(
                            as.numeric(alignDF$lnr1),
                            as.numeric(alignDF$lnr2)  ), ]
    }
    if(sortDF[1] == 1) alignDF <- sort_align_df(alignDF,T)
    if(sortDF[1] == 2) alignDF <- sort_align_df(alignDF,F)

  # results preparation
    res <- list( text1_orig        = text1,
                 text2_orig        = text2,
                 text1_clean       = text1_clean,
                 text2_clean       = text2_clean,
                 distance_matrix   = distance_matrix,
                 alignment_df      = alignDF
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

















