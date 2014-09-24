text_align <- function(distM, maxDist=Inf, retMatrix=T){
  # evaluating maxDiff option to numeric max distance
  md     <- .choose_maxdist_option(distM, maxDist)
  distM[ distM > md ]  <- Inf

  # some general variables and preparations
  nrows  <- dim(distM)[1]
  ncols  <- dim(distM)[2]
  rows   <- seq_len(nrows)
  cols   <- seq_len(ncols)
  rownames(distM) <- rows
  colnames(distM) <- cols

  used_cols <- rep(FALSE, ncols)
  used_rows <- rep(FALSE, nrows)
  AlignM    <- matrix(FALSE, nrows, ncols)
  rowset    <- rows[apply(distM, 1, min) == min(distM) & min(distM)!=Inf]

  # align lines in ...
  # 1. inverse order of distance;
  # 2. order of appearance in text
  while (length(rowset)>0) {
    for( i in rowset ){
      rowmin    <- min(distM[i,])
      distances <- distM[i,]
      align <- seq_len(ncols)[rowmin == distances & !used_cols][1]
      used_cols[align] <- TRUE
      used_rows[i]     <- TRUE
      AlignM[i,align]  <- TRUE
    }
    unused_rows <- rows[!used_rows]
    unused_cols <- cols[!used_cols]
    unused_matr <- distM[unused_rows, unused_cols, drop=F]
    if ( any(dim(unused_matr)==0) | all(unused_matr==Inf)) {
      rowset <- NULL
    }else{
      rowset      <- as.numeric(rownames(unused_matr)[
        apply(unused_matr, 1, min) == min(unused_matr)])
    }
  }

  if(retMatrix){
    AlignM
  }else{
    align_matrix_to_align_df(AlignM, distM=distM)
  }
}







