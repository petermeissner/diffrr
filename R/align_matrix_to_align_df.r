#' Function that transforms an alignment result in matrix form into an alignment result in data frame form
#'
#'@param alignM an alingment matrix
#'@param distM  an distance matrix of same dimensions as alignM

align_matrix_to_align_df <- function(alignM, distM=NULL){
  if(is.null(distM)){
    distM <- matrix( rep(NA, length(alignM)), dim(alignM)[1], dim(alignM)[2])
  }
  unused_rows <- seq_len(dim(alignM)[1])[!apply(alignM,1,sum)>0]
  unused_cols <- seq_len(dim(alignM)[2])[!apply(alignM,2,sum)>0]
  df <- cbind(which(alignM==TRUE, arr.ind=T), dist=distM[alignM==TRUE])
  if ( length(unused_rows)>0 ){
    df <- rbind(df, cbind(unused_rows, NA, NA))
  }
  if ( length(unused_cols)>0 ){
    df <- rbind(df, cbind(NA, unused_cols, NA))
  }
  return(as.data.frame(df))
}
