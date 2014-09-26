#' Set of predefined functions for diffr()
#'
#' Set of functions to calculate distance between each line of first text and
#' each line of second text.
#'

distanceFunctions <- list(

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






