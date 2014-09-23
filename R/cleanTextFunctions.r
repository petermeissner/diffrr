#' Predefined cleanText functions saved in a list.
#'
#' \code{cleanTextFunctions} is a list of predefined functions for text cleansing
#' to be applied before diffr() calculates distances and alignes text
#'
#' @param none does not transform the text at all
#' @param idep used in the data gathering of IDEP (Institutional Design in European Parliaments)
#' working group see citation(diffr) as well as
#' https://github.com/petermeissner/diffr for further information
#'
#'
#' @format list of functions
cleanTextFunctions <- list(
  none = function(text){text},
  idep = function(text){
    idep.regex <- c( "\t",                       #1 tabs to space
                     "  ",                       #2 double spaces to space
                     "^( ?§\\.? ?[[:digit:]]{1,3} ?[[:alpha:]]?\\.? ?)", #3 del paragraph symbol and number at beginning  e.g.: "§81 "    "§ 81"
                     "^(\\(?[[:digit:]]{1,3}\\) ?)",  #4 del digit enclosed in paratheses at beginning e.g.: "(1) "    "1) "
                     "^( ?[[:alpha:]]{1,4}\\. )",  #5 del roman numbers or letter items             e.g.: "VIII. "
                     "^(\\(?[[:alpha:]]\\))",    #6 del letter with parantheses                   e.g.: "(a) "    "a) "
                     "^([[:digit:]]{1,3}[[:alpha:]]?\\.)", # del digits followed by dot and space     e.g.: "1. "     "1A."
                     "^( )",     #8
                     "^(\\-)",   #9
                     "^(\\—\\(?[[:digit:]]?\\)?)", #10
                     "^( )", #11
                     "^[[:digit:]]{1,3}\\.—\\([[:digit:]]\\) ", #12
                     "^( ?\\(?[[:alpha:]]{1,4}\\) )", #13
                     "^(\\([[:digit:]]{1,3}\\) )", #14
                     "^([[:digit:]]{1,2},—\\([[:digit:]]{1,2}\\) )", #15
                     "^([[:digit:]]\\. )", #16
                     "^([[:digit:]]{1,3}\\:\\—\\([[:digit:]]{1,3}\\))", #17
                     "^(capitulo [[:alpha:]]{1,10}\\.?)", #18
                     "^(articulo [[:digit:]]{1,3}\\.?)", #19
                     "^(titulo [[:alpha:]]{1,10}\\.?)", #20
                     "^(seccion [[:digit:]]{1,10}\\.?)", #21
                     "^(seccion [[:alpha:]]{1,10}\\.?)", #22
                     "^(primera.?-? ?|segunda.?-? ?|tercera.?-? ?|cuarta.?-? ?|quinta.?-? ?|sexta.?-? ?|septima.?-? ?|octava.?-? ?|novena.?-? ?|decima.?-? ?)",
                     "^([[:digit:]]{1,3} ?§.? ?)", #24
                     "^([[:digit:]]{1,3} Kap\\. )", #25
                     "^(section [[:digit:]]{1,3} ?—?-? ?)", #26
                     "^(chapter ?[[:digit:]]{1,3} ?—?-? ?)", #27
                     "^(Art[[:alpha:]]?{1,7}.? ?[[:digit:]]{1,3}[[:alpha:]]?{1,10}-?[[:alpha:]]?{1,10}[[:digit:]]?{1,3}.?°?)", #28
                     "^(CHAP[[:alpha:]]?{1,5}.? [[:digit:]]?{1,3}[[:alpha:]]?{1,10}.? ?)", #29
                     "^([[:digit:]]{1,3}°? )", #30
                     "^([[:digit:]]{1,3}°? )", #31
                     "^(er)$", #32
                     "^([[:alpha:]]{1,6}\\. ?–? ?)", #33
                     "^(•)", #34
                     "^(PART [[:alpha:]]{1,10})", #35
                     "^(CAPO [[:alpha:]]{1,10}\\.? )", #36
                     "^([[:digit:]]{1,3}°\\) )", #37
                     "^([[:digit:]]{1,3}-[[:alpha:]]{1,4}\\.? ?)", #38
                     "^([[:alpha:]]{1,6} - )", #39
                     "^(Parte [[:alpha:]]{1,7} - )", #40
                     "^(titre [[:alpha:]]?{1,7}[[:digit:]]?{1,3}\\.? ?-?)", #41
                     "^(Titel [[:alpha:]]?{1,7}[[:digit:]]?{1,3}\\.? ?-?)", #42
                     "^(HOOFDSTUK [[:alnum:]]{1,7}.? ?)", #43
                     "^([[:digit:]]{1,3}\\,)", #44
                     "^(Paragraaf [[:digit:]]{1,3}[[:alpha:]]?\\.)", #45
                     "^([[:alpha:]]{1,10} Kapitel\\.?)", #46
                     "^([[:alpha:]]{1,10} Kapittel\\.?)", #47
                     "^(SEC..O [[:alpha:]]{1,7}\\.?)", #48
                     "^(Cap.tulo [[:alpha:]]{1,7}\\.?)", #49
                     "^(T.TULO [[:alpha:]]{1,7}\\.?)", #50
                     "^( )", #51
                     "^(\\.)", #52
                     "^( )", #53
                     "^([[:alpha:]]?IVIS.O [[:alpha:]]{1,7})", #54
                     "^([[:digit:]]. )", #55
                     "^(Kapitel\\:? [[:alpha:]]?{1,7})", #56
                     "^(Titel\\: )", #57
                     "^([[:digit:]]{1,2}[[:alpha:]])", #58
                     "^([[:digit:]]{1,2}.[[:digit:]]{1,2})", #59
                     "^(Title [[:alpha:]]?{1,7}[[:digit:]]?{1,3}\\.? ?-?)", #60
                     "^(section [[:alpha:]]?{1,7}[[:digit:]]?{1,3}\\.? ?-?)", #61
                     "^[[:digit:]]{1,3}\\.?-\\([[:digit:]]\\) ", #62
                     "^([[:digit:]]{1,2}- )",
                     "^(\\(?\\))")
    for(i in seq_along(idep.regex)){
      text <- gsub( pattern     = idep.regex[i],
                    replacement = "",
                    x           = text      )
    }
    return(text)
  }
)







