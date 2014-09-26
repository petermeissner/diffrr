#' Set of predefined functions for diffr()
#'
#' Set of functions to determine which lines of text to be ignored.
#'

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






