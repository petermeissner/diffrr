#' Predefined functions to determine which lines to ignore for distance
#' calculation and alignment.
#'
#' @param idep ingore empty lines as well as all those starting with '#§#'
#'   (ignore procedure used within IDEP project work)
#' @param empty ingore empty lines
#'
#' @format list of functions


ignoreLinesFunctions <- list(

  idep = function(text){
    pattern <- "^#\u00A7#"
    grepl(pattern, text) & grepl("", text)
  },

  empty = function(text){
    "" == text
  },

  none  = function(text){
    rep(FALSE, length(text))
  }
)






