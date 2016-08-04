#' Function for transforming diffr() results to HTML
#'
#'
#' @export


diffr_to_html <- function(diffrRes, file=F, head="", foot="", clean=F){
  # check inputs
  partsNeeded <- c("text1_orig",  "text2_orig",
                   "text1_clean", "text2_clean",
                   "alignment_df")
  if ( (is.null(diffrRes$text1_orig) & is.null(diffrRes$text1_clean)) |
         is.null(diffrRes$alignment_df)  ){
    stop( "Sorry, diffr_to_html() needs diffr() text as well " %.%
            "as alignment information."                          %.%
            "Make sure to supply a diffr() result containing these info: " %.%
            paste(partsNeeded[(partsNeeded %in% names(diffrRes))], collapse=", ") )
  }

  if ( clean==T ) {
    text1 <- diffrRes$text1_clean
    text2 <- diffrRes$text2_clean
  }else{
    text1 <- diffrRes$text1_orig
    text2 <- diffrRes$text2_orig
  }


  DF    <- diffrRes$alignment_df
  DF    <- add_text_to_alignment(DF, text1, text2)
  trows <- seq_len(dim(DF)[1])
  tcols <- seq_len(dim(DF)[2])


  # build HTML
  if( head=="" ){
    head <- htmlhead
  }
  if( foot=="" ){
    foot <- htmlfoot
  }

  table                  <- "\n<table>\n<thead><tr class='firstLine'>"
  for ( i in tcols ) {
    table[length(table)+1] <-
      "  <th class='firstLineCell'>&nbsp;" %.% names(DF)[i] %.% "&nbsp;</th>"
  }
  table[length(table)+1] <- "</tr></thead>"
  for ( i in trows ) {
    table[length(table)+1] <- "<tr class='" %.%
      stringr::str_replace_all(DF$Type[i]," ","") %.%
      "'>"
    for ( k in tcols ) {
      table[length(table)+1] <-
        "  <td class='" %.% names(DF)[k] %.% "'>" %.% DF[i,k] %.% "</td>"
    }
  }
  table[length(table)+1] <- "\n</table>\n"
  table                  <- "  " %.% table

  # put it together
  res <- c(head, table, foot)

  # decide upon returns
  if ( file==F ) {
    return(res)
  }
  if ( file==T | file=="" ) {
    tmp <- tempfile(fileext=".html")
    writeLines(res, tmp)
    browseURL(tmp)
    invisible(res)
  }
  if ( is.character(file) & file!="" ) {
    writeLines(res, file)
    message(paste("Diffr() results written to file:", file))
    invisible(res)
  }
}
