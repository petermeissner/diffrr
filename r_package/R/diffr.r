globalVariables(
  c(
    "example_A1_split",
    "example_A2_split",
    "htmlhead",
    "htmlfoot"
  )
)

#' A function for aligning text and measuring its distance.
#'
#' This function represents the heart of the diffr package. It can be used to
#' analyze changes made to texts by comparing two versions of the same text.
#'
#' The function tries to align unchanged as well as changed lines to each other
#' and allows to measure the amount of change that occured per line as well as
#' for the whole text.
#'
#' Features of the function include choosing between text cleansing functions,
#' distance functions and line ignore functions or to use functions provided by
#' the user instead. The alignment of the text lines can in addition be tweaked
#' by the use of the maxDist option that allows for a maximum distance for two
#' text lines to be considered as matches. Output can be tweaked by three
#' differing sorting algorithms.
#'
#' @aliases example_A1, example_A2, example_A1_split, example_A2_split,
#'
#' @param text1 First text. Expected to be a character vector or list with each
#'   item repesenting a line. Lists will be transformed to character vectors via
#'   \code{unlist()}. Each vector element of text1 will be compared to each
#'   element of text2.
#'
#' @param text2 Second text. See \code{text1}.
#'
#' @param clean The function to be applied to each line of the text prior to
#'   alignment and difference measurement. The parameter might either be a
#'   string referring to the name of one cleansing function provided by the
#'   package (see \code{names(cleanTextFunctions)}) or should be a user supplied
#'   function. Text cleansing functions are expected to accept one character
#'   vectors as argument and to return a character vector of the very same
#'   length.
#'
#' @param dist The function to be used to calculate distances between text lines
#'   to be used to do the alignment later on. The parameter might either be a
#'   string referring to the name of one distance function provided by the
#'   package (see \code{names(distanceFunctions)}) or should be a user supplied
#'   function. Distance functions are expected to accept character vectors as
#'   first and second argument and to return a matrix of distances between text1
#'   and text2 as intersection between the i_th line and the j_th column -- rows
#'   represent text1 lines and columns represent text2 lines.
#'
#' @param ignore The function to be used to decide whether or not a particular
#'   text line should be excluded from calculations -- distances will still be
#'   calculated (so ignoring lines wont do much about performance) but they are
#'   neither cleaned nor considered for alignment, furthermore those lines do
#'   not count for the overall distance of the text. The parameter might either
#'   be a string referring to the name of one ignore function provided by the
#'   package (see \code{names(ingoreLinesFunctions)}) or should be a user
#'   supplied function. Ignore functions are expected to accept one character
#'   vector as argument and to return a boolean vector of the very same length
#'   that with TRUE for those lines to be ignored and FALSE otherwise.
#'
#' @param maxDist This parameter holds the maximum distance below that it is
#'   acceptable for two lines to be considered as matches. maxDist might either
#'   be supplied as numeric defining the maximum distance in absolute terms or
#'   it might be a string combined of a number between 0 and 100 as well as a \%
#'   character t indicate using a certain percentile of the maximum distance
#'   found between two lines as cut off point.
#'
#' @param sortDF Selects the sorting priority for \code{alignment_df}: Either
#'   \code{0} for no priority, \code{1} for first text priority, or  \code{2}
#'   for second text priority.
#'
#' @param ret The parameter defines what should be returned by the function. The
#'   default value is 'all' while another reasonable value might be 'defaut' to
#'   get only the alignment data frame. Furthermore, one can supply a vector
#'   with the names of those objects that should be returned:
#'   \code{c("text1_orig", "text2_orig", "text1_clean", "text2_clean",
#'   "distance_matrix", "alignment_df")}.
#'
#' @return The function returns a list with items: \itemize{ \item
#'   \code{text1_orig} and \code{text2_orig} holding the original texts, \item
#'   \code{text1_clean} and \code{text2_clean} holding the texts after cleaning,
#'   \item \code{alignment_df} data frame holding the corresponding line numbers
#'   from \code{text1} and \code{text2}, the distance between them and the
#'   corresponding match type\item \code{distance_matrix} a matrix of distances
#'   between text lines -- rows for text1 and columns for text2 }
#'
#' @export
#'
#' @examples
#' ## diffr(example_A1_split, example_A2_split)


diffr <- function(text1   = example_A1_split,
                  text2   = example_A2_split,
                  clean   = "none",
                  dist    = "levenshtein",
                  maxDist = "Inf",
                  sortDF  = c(1,2,0),
                  ignore  = "empty",
                  ret     = "all"){

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
    class(alignDF) <- c("align_df", class(alignDF))
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
                 alignment_df      = alignDF,
                 print             =
                   data.frame(
                    lnr1  = alignDF$lnr1,
                    lnr2  = alignDF$lnr2,
                    text1 = text1[alignDF$lnr1] ,
                    text2 = text2[alignDF$lnr2] ,
                    dist  = alignDF$distance,
                    type  = alignDF$type
                )
    )
    class(res) <- c("diffr", class(res))

  # return
    if ( all(ret == "all") ) {
      return(res)
    }
    if ( all(ret == "default") ) {
      return(res$alignment_df)
    }
    if ( length(ret)>1 ){
      return(res[ret])
    }
}



#' print method for diffr objects
#'
#' @keywords internal
#'
print.diffr <- function(diffr){
  print(diffr$print)
  return(diffr)
}



#' plot method for diffr objects
#'
#' @keywords internal
#'
plot.diffr <- function(diffr){
  col <- function(type="") {
    switch(as.character(type),
           ignore = "grey",
           ins    = "blue",
           del    = "red",
           equal  = "green",
           mod    = "yellow",
           "purple"
    )
  }
  LWD=1.5
  rows <- max(max(diffr$print$lnr1, na.rm=TRUE), max(diffr$print$lnr2, na.rm=TRUE))
  diffr$print$lnr2<-0-diffr$print$lnr2 +rows+1
  diffr$print$lnr1<-0-diffr$print$lnr1 +rows+1
  plot(c(0.8,4.2), c(0,rows+1), xlab = "versions", ylab = "line numbers",
       col="white", yaxs = "i", xaxs = "i", axes = FALSE)
  graphics::axis(1, at = c(1.5,3.5), labels=c("1", "2"))
  graphics::axis(2, at = c(1,rows), labels = c(rows,1))
  graphics::box()
  iffer <- !is.na(diffr$print$lnr1) & !is.na(diffr$print$lnr2)
  n <- sum(iffer)
  for(i in seq_len(n)){
    spline <- as.data.frame(graphics::xspline(
      x=1:4,
      y=c(diffr$print[iffer, "lnr1"][i], diffr$print[iffer, "lnr1"][i],
          diffr$print[iffer, "lnr2"][i], diffr$print[iffer, "lnr2"][i]),
      s=c(1,1,1,1), draw=FALSE
    ))
    graphics::lines(spline, col=col(diffr$print[iffer, "type"][i]), lwd=LWD)
  }
  iffer <- !is.na(diffr$print$lnr1) & is.na(diffr$print$lnr2)
  n <- sum(iffer)
  for(i in seq_len(n)){
    spline <- data.frame(
      x=c(1,1.5),
      y=c(diffr$print[iffer, "lnr1"][i], diffr$print[iffer, "lnr1"][i]))
    graphics::lines(spline, col=col(diffr$print[iffer, "type"][i]), lwd=LWD)
  }
  iffer <- is.na(diffr$print$lnr1) & !is.na(diffr$print$lnr2)
  n <- sum(iffer)
  for(i in seq_len(n)){
    spline <- data.frame(
      x=c(3.5,4),
      y=c(diffr$print[iffer, "lnr2"][i], diffr$print[iffer, "lnr2"][i]))
    graphics::lines(spline, col=col(diffr$print[iffer, "type"][i]), lwd=LWD)
  }
}











