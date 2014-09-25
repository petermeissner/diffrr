# README
Peter Meißner  
Wednesday, September 24, 2014  


# diffr 
A package for measuring change between different versions of text

## Description


A package for measuring change between different versions of text by automatically
or semi-automatically aligning text lines and measuring the change. It works kind of like diff
or version control systems but focuses on **measuring** the **change** in contrast to focusing on
solid version control. Furthermore, the package allows for (possibly user made) text cleaning
functions that are applied before comparison. Another feature is the semi-automatic alignment
that allows for fast computer decissions on clear alignments of 100% matches and 0% matches
while asking for human input on more complex decissions.
  

## Installation


    # require(devtools)
    # install_github("petermeissner/diffr")
    # require(diffr)

    
## Links

- http://www.polver.uni-konstanz.de/sieberer/forschung/


## Example Usage




```r
    library(diffr)

    res <- diffr(example_A1_split, example_A2_split, 
                 clean="none", dist="levenwords", sortDF=0)
```

```
## Loading required package: cba
## Loading required package: grid
## Loading required package: proxy
## 
## Attaching package: 'proxy'
## 
## The following objects are masked from 'package:stats':
## 
##     as.dist, dist
```

```r
    names(res)
```

```
## [1] "text1_orig"      "text2_orig"      "text1_clean"     "text2_clean"     "distance_matrix" "alignment_df"
```

```r
    # total difference between both texts:
    sum(res$alignment_df$dist)
```

```
## [1] 46
```

```r
    # alignment of texts
    head(res$alignment_df)
```

```
##   lnr1 lnr2 distance
## 2    1    7        0
## 3    2    8        0
## 4    3    9        0
## 5    4   10        0
## 6    5   11        0
## 7    6   12        0
```

```r
    # alignment of texts with texts
    data.frame( lnr1  = res$alignment_df$lnr1, 
                lnr2  = res$alignment_df$lnr2, 
                text1 = res$text1_orig[res$alignment_df$lnr1] ,
                text2 = res$text2_orig[res$alignment_df$lnr2] ,
                dist  = res$alignment_df$distance
         )
```

```
##    lnr1 lnr2                        text1                        text2 dist
## 1     1    7             This part of the             This part of the    0
## 2     2    8      document has stayed the      document has stayed the    0
## 3     3    9         same from version to         same from version to    0
## 4     4   10       version.  It shouldn't       version.  It shouldn't    0
## 5     5   11       be shown if it doesn't       be shown if it doesn't    0
## 6     6   12     change.  Otherwise, that     change.  Otherwise, that    0
## 7     7   13      would not be helping to      would not be helping to    0
## 8     8   NA     compress the size of the                         <NA>    5
## 9     9   NA                     changes.                         <NA>    1
## 10   10    6                                                              0
## 11   11   26      This paragraph contains      This paragraph contains    0
## 12   12   NA       text that is outdated.                         <NA>    4
## 13   13   NA    It will be deleted in the                         <NA>    6
## 14   14   NA                 near future.                         <NA>    2
## 15   15   15                                                              0
## 16   16   16     It is important to spell     It is important to spell    0
## 17   17   17      check this dokument. On      check this document. On    2
## 18   18   18            the other hand, a            the other hand, a    0
## 19   19   19        misspelled word isn't        misspelled word isn't    0
## 20   20   20        the end of the world.        the end of the world.    0
## 21   21   21       Nothing in the rest of       Nothing in the rest of    0
## 22   22   22      this paragraph needs to      this paragraph needs to    0
## 23   23   23       be changed. Things can       be changed. Things can    0
## 24   24   24           be added after it.           be added after it.    0
## 25   25   29                                                              0
## 26   26   30             Source of Text:              Source of Text:     0
## 27   27   31    Diff. (2014, August 26).     Diff. (2014, August 26).     0
## 28   28   32               In Wikipedia,                In Wikipedia,     0
## 29   29   33       The Free Encyclopedia.       The Free Encyclopedia.    0
## 30   30   34            Retrieved 10:14,             Retrieved 10:14,     0
## 31   31   35         September 24, 2014,          September 24, 2014,     0
## 32   32   36 from http://en.wikipedia.org from http://en.wikipedia.org    0
## 33   33   37      /w/index.php?title=Diff      /w/index.php?title=Diff    0
## 34   34   38             &oldid=622929855             &oldid=622929855    0
## 35   NA    1                         <NA>         This is an important    4
## 36   NA    2                         <NA>            notice! It should    4
## 37   NA    3                         <NA>      therefore be located at    4
## 38   NA    4                         <NA>        the beginning of this    4
## 39   NA    5                         <NA>                    document!    1
## 40   NA   14                         <NA>           compress anything.    2
## 41   NA   25                         <NA>                                 1
## 42   NA   27                         <NA>      important new additions    3
## 43   NA   28                         <NA>            to this document.    3
```
    
    

    
    
    
    
    
    
    
    
    
    
