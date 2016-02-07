htmlhead <- readLines("head.html")
Encoding(htmlhead)   <- "latin1"
save(htmlhead, file="../data/htmlhead.rdata")

htmlfoot <- readLines("foot.html")
Encoding(htmlfoot)   <- "latin1"
save(htmlfoot, file="../data/htmlfoot.rdata")
