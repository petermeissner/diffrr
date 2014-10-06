#' Helper function for diffr_to_html that combines alignment_df and text
#'
#'


add_text_to_alignment <- function(alignDF, text1, text2){
  text1 <- text1[as.numeric(alignDF$lnr1)]
  text1[is.na(text1)] <- '<font size="1" color="grey">NA</font>'
  text2 <- text2[as.numeric(alignDF$lnr2)]
  text2[is.na(text2)] <- '<font size="1" color="grey">NA</font>'
  alignDF$distance[is.na(alignDF$distance)] <- '<font size="1" color="grey">NA</font>'
  alignDF$lnr1[is.na(alignDF$lnr1)] <- '<font size="1" color="grey">NA</font>'
  alignDF$lnr2[is.na(alignDF$lnr2)] <- '<font size="1" color="grey">NA</font>'

  data.frame(
    'nr'  = rownames(alignDF),
    LNr1  = alignDF$lnr1,
    Text1 = text1,
    LNr2  = alignDF$lnr2,
    Text2 = text2,
    Type  = alignDF$type,
    Distance = alignDF$distance
    )
}

