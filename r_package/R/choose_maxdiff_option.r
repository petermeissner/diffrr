#' Function for translating maxdiff option into value
#'
#' @param distM A distance matrixe calculated by one of the functions from
#'   \code{distanceFunctions}.
#'
#' @param maxDist The maxDist option to decide upon.

choose_maxdist_option <- function(distM, maxDist="Inf"){
  # handling maxDist parameters
  # maxDist might be set to "Inf", "auto", "10%" or some specific value
  md_inf  <- grepl("Inf",    maxDist[1], ignore.case=T) | maxDist==Inf
  md_auto <- grepl("^auto$", maxDist[1], ignore.case=T)
  md_perc <- grepl("%$",     maxDist[1])
  md_num  <- is.numeric(maxDist)

  if( all(c(md_inf, md_auto, md_perc, md_num)) ){
    md <- Inf
    warning("No valid argument for 'maxDist' supplied, 'maxDist' set to 'Inf'.")
  }else{
    if( md_inf  ) md <- Inf
    if( md_auto ) md <- stats::quantile(distM, (100-   10       )/100 )
    if( md_perc ){
      md_perc_value  <- stringr::str_replace(maxDist, "%","")
      md_perc_value  <- as.numeric(md_perc_value)
      md             <- stats::quantile(distM, (100-md_perc_value)/100 )
    }
    if( md_num  ) md <- maxDist
  }
  return(md)
}
