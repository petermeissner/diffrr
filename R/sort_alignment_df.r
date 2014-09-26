#' function sorting alignment data frames according to line numbers
#'
#' @param alignDF the alignment data frame to be sorted
#' @param text1First should first text or second text be given priority
#'
sort_align_df <- function(alignDF, text1First=T){
  lnr1     <- alignDF$lnr1
  lnr2     <- alignDF$lnr2
  looper   <- seq_len(max(lnr1, lnr2, na.rm=T))
  data_nr  <- seq_along(alignDF[,1])

  sorter <- NULL
  if ( text1First == T  ){
    for ( i in looper ){
      sorter <- c(  sorter                                            ,
                    data_nr[ i==lnr1 & !is.na(lnr1) &   is.na(lnr2) ] ,
                    data_nr[ i==lnr1 & !is.na(lnr1) &  !is.na(lnr2) ] ,
                    data_nr[ i==lnr2 &  is.na(lnr1) &  !is.na(lnr2) ] )
    }
    return(alignDF[sorter,])
  }
  if ( text1First == F  ){
    for ( i in data_nr ){
      sorter <- c(  sorter                                            ,
                    data_nr[ i==lnr2 & !is.na(lnr2) &   is.na(lnr1) ] ,
                    data_nr[ i==lnr2 & !is.na(lnr2) &  !is.na(lnr1) ] ,
                    data_nr[ i==lnr1 &  is.na(lnr2) &  !is.na(lnr1) ] )
    }
    return(alignDF[sorter,])
  }
}
