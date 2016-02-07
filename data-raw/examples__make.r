#' first text of running example A as one string
example_A1      = "This part of the\ndocument has stayed the\nsame from version to\nversion.  It shouldn't\nbe shown if it doesn't\nchange.  Otherwise, that\nwould not be helping to\ncompress the size of the\nchanges.\n\nThis paragraph contains\ntext that is outdated.\nIt will be deleted in the\nnear future.\n\nIt is important to spell\ncheck this dokument. On\nthe other hand, a\nmisspelled word isn't\nthe end of the world.\nNothing in the rest of\nthis paragraph needs to\nbe changed. Things can\nbe added after it.

Source of Text: \nDiff. (2014, August 26). \nIn Wikipedia, \nThe Free Encyclopedia.\n Retrieved 10:14, \nSeptember 24, 2014, \nfrom http://en.wikipedia.org\n/w/index.php?title=Diff\n&oldid=622929855"

#' first text of running example A as character vector
example_A1_split <- unlist(strsplit(example_A1, "\n"))

#' second text of ruinning example A as one string
example_A2      = "This is an important\nnotice! It should\ntherefore be located at\nthe beginning of this\ndocument!\n\nThis part of the\ndocument has stayed the\nsame from version to\nversion.  It shouldn't\nbe shown if it doesn't\nchange.  Otherwise, that\nwould not be helping to\ncompress anything.\n\nIt is important to spell\ncheck this document. On\nthe other hand, a\nmisspelled word isn't\nthe end of the world.\nNothing in the rest of\nthis paragraph needs to\nbe changed. Things can\nbe added after it.\n\nThis paragraph contains\nimportant new additions\nto this document.

Source of Text: \nDiff. (2014, August 26). \nIn Wikipedia, \nThe Free Encyclopedia.\n Retrieved 10:14, \nSeptember 24, 2014, \nfrom http://en.wikipedia.org\n/w/index.php?title=Diff\n&oldid=622929855"

#' second text of ruinning example A  as character vector
example_A2_split <- unlist(strsplit(example_A2, "\n"))



# saving 
save(example_A1,        file="../data/example_A1.rdata")
save(example_A2,        file="../data/example_A2.rdata")
save(example_A1_split,  file="../data/example_A1_split.rdata")
save(example_A2_split,  file="../data/example_A2_split.rdata")