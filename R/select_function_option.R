#' diffr() helper function for options
#'
#' Function handles character and function inputs. If input is a string the
#' function looks if it finds corresponding function in the function list (e.g.
#' in \code{distanceFunctions}, \code{cleanTextFunctions},
#' \code{ignoreLinesFunctions}). If the input is a function instead it simply
#' returns taht function.
#'
#' Returns a function or an error.
#'
#' @param option Parameter to supply the option value to decide upon.
#'
#' @param optionList Parameter to supply list of functions to select from (e.g.
#'   \code{cleanTextFunctions}, \code{distanceFunctions},
#'   \code{ignoreLinesFunctions}).

select_function_option <- function(option, optionList){
  if(class(option)=="character" ){
    if( !(option %in% names(optionList)) ){
      stop(
        paste( "No such function as '" ,
               option ,
               "' to be found. Try: '",
               paste(names(optionList), collapse="', '"),
               "' ", sep="")
      )
    }
    option <- optionList[[option]]
  }
  if( class(option)!= "function"){
    stop("Parameter supplied is neither one of the package defaults nor a function.")
  }
  option
}
