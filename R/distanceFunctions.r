#' Predefined similarity functions saved in a list.
#'
#' \code{similarityFunctions} is a list of predefined functions for text
#' distance calculation
#'
#' @param nchar similarity calculated based on number of characters
#' @param nwords similarity calculated based on number of words
#' @param leven similarity calculated based on Levenshtein distance (\code{dist()} from \code{proxy} package used for that)
#' @param levenwords  similarity calculated based on Levenshtein distance that uses words instead of characters as smallest parts (\code{dist()} from \code{proxy} package used for that)
#' @param bow similarity calculated based on
#' @param idep see bow (distance measure used within IDEP project work)
#'
#' @seealso \code{\link[proxy]{pr_DB}} or try: \code{proxy::pr_DB$get_entries(name = NULL, pattern = NULL)}.
#'
#' @examples names(distanceFunctions)
#'
#' @format list of functions
distanceFunctions <- list(

  # Length comparison on Character Basis
  numberchars = function(text1,text2){
    worker  <- function(text1,text2){
      if ( !is.null(dim(text1)) | length(text1)!=1 | !is.null(dim(text2)) | length(text2)!=1 ) {
        stop("Character vector supplied to worker function should be of length 1")
      }
      text1_length <- nchar(text1)
      text2_length <- nchar(text2)
      dist         <- abs(text1_length - text2_length)
      return(dist)
    }
    vworker  <- function(text1,text2){
      dist   <- mapply(worker, text1, text2)
      return(dist)
    }
    dist <- outer(text1, text2, vworker)
    return(dist)
  },

  # Length Comparison on Word Basis
  numberwords = function(text1,text2){
    worker  <- function(text1,text2){
      if ( !is.null(dim(text1)) | length(text1)!=1 | !is.null(dim(text2)) | length(text2)!=1 ) {
        stop("Character vector supplied to worker function should be of length 1")
      }
      text1_split  <- strsplit(text1, "[[:space:][:punct:]]")[[1]]
      text2_split  <- strsplit(text2, "[[:space:][:punct:]]")[[1]]
      text1_length <- length(text1_split[text1_split!=""])
      text2_length <- length(text2_split[text2_split!=""])
      dist         <- abs(text1_length - text2_length)
      return(dist)
    }
    vworker  <- function(text1,text2){
      dist   <- mapply(worker, text1, text2)
      return(dist)
    }
    dist <- outer(text1, text2, vworker)
    return(dist)
  },

  # Levenshtein
  levenshtein = function(text1, text2){
    dist <- proxy::dist(text1,text2, method="Levenshtein")
    class(dist) <- "matrix"
    return(dist)
  },

  # Levensthein on Word Basis
  levenwords  = function(text1, text2){
    text1_words <- strsplit(text1 ,"[[:punct:][:space:]]")
    text2_words <- strsplit(text2 ,"[[:punct:][:space:]]")
    dist <- proxy::dist(text1_words, text2_words, method="Levenshtein")
    class(dist) <- "matrix"
    return(dist)
  },

  # Bag of Words
  bow   = function(text1, text2){
    worker <- function(text1, text2){
      if(!(is.character(text1) & is.character(text2))){
        stop("Texts supplied should be character")
      }
      text1_split <- unlist(strsplit(text1, "[[:space:][:punct:]]"))
      text2_split <- unlist(strsplit(text2, "[[:space:][:punct:]]"))
      text1_table <- table(text1_split[text1_split!=""])
      text2_table <- table(text2_split[text2_split!=""])
      texts_words <- unique(c(names(text1_table), names(text2_table)))
      texts_comp  <- cbind( text1_table[match(texts_words, names(text1_table))],
                            text2_table[match(texts_words, names(text2_table))] )
      texts_comp[is.na(texts_comp)] <- 0
      dist <- sum(abs(texts_comp[,1]-texts_comp[,2]))
      return(dist)
    }
    vworker  <- function(text1, text2){
      dist   <- mapply(worker, text1, text2)
      return(dist)
    }
    dist <- outer(text1, text2, vworker)
    return(dist)
  },

  # IDEP project distance (Bag of Words)
  idep  = function(text1, text2){
    worker <- function(text1, text2){
      if(!(is.character(text1) & is.character(text2))){
        stop("Texts supplied should be character")
      }
      text1_split <- unlist(strsplit(text1, "[[:space:][:punct:]]"))
      text2_split <- unlist(strsplit(text2, "[[:space:][:punct:]]"))
      text1_table <- table(text1_split[text1_split!=""])
      text2_table <- table(text2_split[text2_split!=""])
      texts_words <- unique(c(names(text1_table), names(text2_table)))
      texts_comp  <- cbind( text1_table[match(texts_words, names(text1_table))],
                            text2_table[match(texts_words, names(text2_table))] )
      texts_comp[is.na(texts_comp)] <- 0
      dist <- sum(abs(texts_comp[,1]-texts_comp[,2]))
      return(dist)
    }
    vworker  <- function(text1, text2){
      dist   <- mapply(worker, text1, text2)
      return(dist)
    }
    dist <- outer(text1, text2, vworker)
    return(dist)
  }
)






