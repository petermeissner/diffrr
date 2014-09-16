#' this is some extra stuff for developement

text1      = "This part of the\ndocument has stayed the\nsame from version to\nversion.  It shouldn't\nbe shown if it doesn't\nchange.  Otherwise, that\nwould not be helping to\ncompress the size of the\nchanges.\n \nThis paragraph contains\ntext that is outdated.\nIt will be deleted in the\nnear future.\n \nIt is important to spell\ncheck this dokument. On\nthe other hand, a\nmisspelled word isn't\nthe end of the world.\nNothing in the rest of\nthis paragraph needs to\nbe changed. Things can\nbe added after it."

#' this is some extra stuff for developement
text2      = "This is an important\nnotice! It should\ntherefore be located at\nthe beginning of this\ndocument!\n \nThis part of the\ndocument has stayed the\nsame from version to\nversion.  It shouldn't\nbe shown if it doesn't\nchange.  Otherwise, that\nwould not be helping to\ncompress anything.\n \nIt is important to spell\ncheck this document. On\nthe other hand, a\nmisspelled word isn't\nthe end of the world.\nNothing in the rest of\nthis paragraph needs to\nbe changed. Things can\nbe added after it.\n \nThis paragraph contains\nimportant new additions\nto this document."

#' this is some extra stuff for developement
alignExample <- list(
  text2_orig      = c("ab","cd","df"),
  text2_orig      = c("ac","cd","def","klm"),
  text2_clean     = c("b","d","f"),
  text2_clean     = c("c","d","ef","lm"),
  alignment_auto  = cbind( c(1,2,3), c(1,2,3) ),
  alignment_semi  = cbind( c(1,2,3,3), c(1,2,3,4) ),
  distance_veca   = c(0,1,0),
  distance_vecs   = c(0,1,0,1),
  distance_matrix = matrix(c(0,1,1,1,1,0,1,1,1,1,0,1),3,4,byrow=T)
)
