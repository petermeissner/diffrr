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
                 clean="none", dist="levenwords")
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
## [1] "text1_orig"      "text2_orig"      "text1_clean"     "text2_clean"    
## [5] "distance_matrix" "alignment_df"
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
    res$alignment_df
```

```
##    lnr1 lnr2 distance
## 1    10    6        0
## 2     1    7        0
## 3     2    8        0
## 4     3    9        0
## 5     4   10        0
## 6     5   11        0
## 7     6   12        0
## 8     7   13        0
## 9    15   15        0
## 10   16   16        0
## 11   17   17        2
## 12   18   18        0
## 13   19   19        0
## 14   20   20        0
## 15   21   21        0
## 16   22   22        0
## 17   23   23        0
## 18   24   24        0
## 19   11   26        0
## 20   25   29        0
## 21   26   30        0
## 22   27   31        0
## 23   28   32        0
## 24   29   33        0
## 25   30   34        0
## 26   31   35        0
## 27   32   36        0
## 28   33   37        0
## 29   34   38        0
## 30    8   NA        5
## 31    9   NA        1
## 32   12   NA        4
## 33   13   NA        6
## 34   14   NA        2
## 35   NA    1        4
## 36   NA    2        4
## 37   NA    3        4
## 38   NA    4        4
## 39   NA    5        1
## 40   NA   14        2
## 41   NA   25        1
## 42   NA   27        3
## 43   NA   28        3
```

```r
    # alignment of texts with texts
    cbind( res$alignment_df, 
           text1=res$text1_orig[res$alignment_df$lnr1] ,
           text2=res$text2_orig[res$alignment_df$lnr2] 
         )
```

```
##    lnr1 lnr2 distance                        text1
## 1    10    6        0                             
## 2     1    7        0             This part of the
## 3     2    8        0      document has stayed the
## 4     3    9        0         same from version to
## 5     4   10        0       version.  It shouldn't
## 6     5   11        0       be shown if it doesn't
## 7     6   12        0     change.  Otherwise, that
## 8     7   13        0      would not be helping to
## 9    15   15        0                             
## 10   16   16        0     It is important to spell
## 11   17   17        2      check this dokument. On
## 12   18   18        0            the other hand, a
## 13   19   19        0        misspelled word isn't
## 14   20   20        0        the end of the world.
## 15   21   21        0       Nothing in the rest of
## 16   22   22        0      this paragraph needs to
## 17   23   23        0       be changed. Things can
## 18   24   24        0           be added after it.
## 19   11   26        0      This paragraph contains
## 20   25   29        0                             
## 21   26   30        0             Source of Text: 
## 22   27   31        0    Diff. (2014, August 26). 
## 23   28   32        0               In Wikipedia, 
## 24   29   33        0       The Free Encyclopedia.
## 25   30   34        0            Retrieved 10:14, 
## 26   31   35        0         September 24, 2014, 
## 27   32   36        0 from http://en.wikipedia.org
## 28   33   37        0      /w/index.php?title=Diff
## 29   34   38        0             &oldid=622929855
## 30    8   NA        5     compress the size of the
## 31    9   NA        1                     changes.
## 32   12   NA        4       text that is outdated.
## 33   13   NA        6    It will be deleted in the
## 34   14   NA        2                 near future.
## 35   NA    1        4                         <NA>
## 36   NA    2        4                         <NA>
## 37   NA    3        4                         <NA>
## 38   NA    4        4                         <NA>
## 39   NA    5        1                         <NA>
## 40   NA   14        2                         <NA>
## 41   NA   25        1                         <NA>
## 42   NA   27        3                         <NA>
## 43   NA   28        3                         <NA>
##                           text2
## 1                              
## 2              This part of the
## 3       document has stayed the
## 4          same from version to
## 5        version.  It shouldn't
## 6        be shown if it doesn't
## 7      change.  Otherwise, that
## 8       would not be helping to
## 9                              
## 10     It is important to spell
## 11      check this document. On
## 12            the other hand, a
## 13        misspelled word isn't
## 14        the end of the world.
## 15       Nothing in the rest of
## 16      this paragraph needs to
## 17       be changed. Things can
## 18           be added after it.
## 19      This paragraph contains
## 20                             
## 21             Source of Text: 
## 22    Diff. (2014, August 26). 
## 23               In Wikipedia, 
## 24       The Free Encyclopedia.
## 25            Retrieved 10:14, 
## 26         September 24, 2014, 
## 27 from http://en.wikipedia.org
## 28      /w/index.php?title=Diff
## 29             &oldid=622929855
## 30                         <NA>
## 31                         <NA>
## 32                         <NA>
## 33                         <NA>
## 34                         <NA>
## 35         This is an important
## 36            notice! It should
## 37      therefore be located at
## 38        the beginning of this
## 39                    document!
## 40           compress anything.
## 41                             
## 42      important new additions
## 43            to this document.
```
    
    
    
    
    
    
    
    
    
    
    
    
    
