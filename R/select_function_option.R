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
