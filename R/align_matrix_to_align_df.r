#' Function that transforms an alignment result in matrix form into an alignment result in data frame form
#'
#'@param alignM an alingment matrix
#'@param distM  an distance matrix of same dimensions as alignM

align_matrix_to_align_df <- function(alignM,
                                     distM=NULL,
                                     text1_indel_dist=NA,
                                     text2_indel_dist=NA){
  # preparation and option handling
    if(is.null(distM)){
      distM <- matrix( rep(NA, length(alignM)), dim(alignM)[1], dim(alignM)[2])
    }
    unused_rows <- seq_len(dim(alignM)[1])[!apply(alignM,1,sum)>0]
    unused_cols <- seq_len(dim(alignM)[2])[!apply(alignM,2,sum)>0]

    if ( length(unused_rows)>0 ) {
      rows_indel_dist <- text1_indel_dist[unused_rows]
    }
    if ( length(unused_cols)>0 ) {
      cols_indel_dist <- text2_indel_dist[unused_cols]
    }

  # matrix to data frame (matches)
    df <- cbind(which(alignM==TRUE, arr.ind=T), dist=distM[alignM==TRUE])

  # add insertions and deletions from text1 and text2
    if ( length(unused_rows)>0 ){
      df <- rbind(df, cbind(unused_rows, NA, rows_indel_dist))
    }
    if ( length(unused_cols)>0 ){
      df <- rbind(df, cbind(NA, unused_cols, cols_indel_dist))
    }
    df <- as.data.frame(df)
    names(df) <- c("lnr1","lnr2","distance")

  # compute type (insertion, deletion, change, no change, ignore)
    align_type <- function(alignRow){
      lnr1     <- alignRow[1]
      lnr2     <- alignRow[2]
      distance <- alignRow[3]
      if( !any(is.na(alignRow)) ){
        if( distance==0 ) return("no change")
        if( distance> 0 ) return("change")
      }
      if( all(is.na(alignRow)) ){
        return("empty!")
      }
      if( is.na(lnr1) & is.na(distance) ){
        return("ignore")
      }
      if( is.na(lnr2) & is.na(distance) ){
        return("ignore")
      }
      if( is.na(lnr1) ){
        return("insertion")
      }
      if( is.na(lnr2) ){
        return("deletion")
      }
    }
    df$type = apply(df, 1, align_type)

  # return results
    return(df)
}





