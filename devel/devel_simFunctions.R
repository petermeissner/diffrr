numberwords <- function(text1,text2){
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
  outer(text1, text2, vworker)
}


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
  outer(text1, text2, vworker)
}


a <- text1[1:3]
b <- text2[1:2]

a <- "Hallo there"
b <- c("there Hallo", "Hallo there PEter")







