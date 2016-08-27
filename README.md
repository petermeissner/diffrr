
Comparing and aligning text
===========================

**Status**

[![Travis-CI Build Status](https://travis-ci.org/petermeissner/diffr.svg?branch=master)](https://travis-ci.org/petermeissner/diffr) [![codecov](https://codecov.io/gh/petermeissner/diffr/branch/master/graph/badge.svg)](https://codecov.io/gh/petermeissner/diffr/tree/master/R)

*lines of R code:* 506, *lines of C++ code:* 0, *lines of test code:* 0

**Version**

0.1.3

**Description**

A package for measuring change between different versions of text by automatically or semi-automatically aligning text lines and measuring the change. It works kind of like diff or version control systems but focuses on measuring the change in contrast to focusing on solid version control. Furthermore, the package allows for (possibly user made) text cleaning functions that are applied before comparison. Another feature is the semi-automatic alignment that allows for fast computer decissions on clear alignments of 100% matches and 0% matches while asking for human input on more complex decissions.

**License**

MIT + file LICENSE <br>Peter Meissner (<retep.meissner@gmail.com>)

**Citation**

Meißner P (2016). *diffrprojects: Using diffr for more than two texts*. R package version 0.1.3.90000, &lt;URL: <https://github.com/petermeissner/diffrprojects>&gt;.

Sieberer U, Meißner P, Keh J and Müller W (2016). "Mapping and Explaining Parliamentary Rule Changes in Europe: A Research Program." *Legislative Studies Quarterly*, *41*(1), pp. 61-88. ISSN 1939-9162, doi: 10.1111/lsq.12106 (URL: <http://doi.org/10.1111/lsq.12106>), &lt;URL: <http://dx.doi.org/10.1111/lsq.12106>&gt;.

**BibTex for citing**

``` r
toBibtex(citation("diffrprojects"))
```

**Installation**

``` r
install.packages("diffrprojects", repos = "https://petermeissner.github.io/drat")
```

**Links**

-   <http://www.polver.uni-konstanz.de/sieberer/forschung/>
-   <http://link.springer.com/article/10.1007%2Fs12286-014-0216-7>

**Example Usage**

``` r
    require(diffr)
```

    ## Loading required package: diffr

``` r
    res <- diffr(example_A1_split, example_A2_split, 
                 clean="none", dist="levenwords", sortDF=0)

    names(res)
```

    ## [1] "text1_orig"      "text2_orig"      "text1_clean"     "text2_clean"     "distance_matrix" "alignment_df"    "print"

``` r
    # total difference between both texts:
    sum(res$alignment_df$dist, na.rm=T)
```

    ## [1] 45

``` r
    # alignment of texts
    head(res$alignment_df)
```

    ##   lnr1 lnr2 distance  type
    ## 2    1    7        0 equal
    ## 3    2    8        0 equal
    ## 4    3    9        0 equal
    ## 5    4   10        0 equal
    ## 6    5   11        0 equal
    ## 7    6   12        0 equal

``` r
    # alignment of texts with texts
    res$print
```

    ##    lnr1 lnr2                        text1                        text2 dist   type
    ## 1     1    7             This part of the             This part of the    0  equal
    ## 2     2    8      document has stayed the      document has stayed the    0  equal
    ## 3     3    9         same from version to         same from version to    0  equal
    ## 4     4   10       version.  It shouldn't       version.  It shouldn't    0  equal
    ## 5     5   11       be shown if it doesn't       be shown if it doesn't    0  equal
    ## 6     6   12     change.  Otherwise, that     change.  Otherwise, that    0  equal
    ## 7     7   13      would not be helping to      would not be helping to    0  equal
    ## 8     8   NA     compress the size of the                         <NA>    5    del
    ## 9     9    5                     changes.                    document!    2    mod
    ## 10   10   NA                                                      <NA>   NA ignore
    ## 11   11   26      This paragraph contains      This paragraph contains    0  equal
    ## 12   12   NA       text that is outdated.                         <NA>    4    del
    ## 13   13   NA    It will be deleted in the                         <NA>    6    del
    ## 14   14   NA                 near future.                         <NA>    2    del
    ## 15   15   NA                                                      <NA>   NA ignore
    ## 16   16   16     It is important to spell     It is important to spell    0  equal
    ## 17   17   17      check this dokument. On      check this document. On    2    mod
    ## 18   18   18            the other hand, a            the other hand, a    0  equal
    ## 19   19   19        misspelled word isn't        misspelled word isn't    0  equal
    ## 20   20   20        the end of the world.        the end of the world.    0  equal
    ## 21   21   21       Nothing in the rest of       Nothing in the rest of    0  equal
    ## 22   22   22      this paragraph needs to      this paragraph needs to    0  equal
    ## 23   23   23       be changed. Things can       be changed. Things can    0  equal
    ## 24   24   24           be added after it.           be added after it.    0  equal
    ## 25   25   NA                                                      <NA>   NA ignore
    ## 26   26   30             Source of Text:              Source of Text:     0  equal
    ## 27   27   31    Diff. (2014, August 26).     Diff. (2014, August 26).     0  equal
    ## 28   28   32               In Wikipedia,                In Wikipedia,     0  equal
    ## 29   29   33       The Free Encyclopedia.       The Free Encyclopedia.    0  equal
    ## 30   30   34            Retrieved 10:14,             Retrieved 10:14,     0  equal
    ## 31   31   35         September 24, 2014,          September 24, 2014,     0  equal
    ## 32   32   36 from http://en.wikipedia.org from http://en.wikipedia.org    0  equal
    ## 33   33   37      /w/index.php?title=Diff      /w/index.php?title=Diff    0  equal
    ## 34   34   38             &oldid=622929855             &oldid=622929855    0  equal
    ## 35   NA    1                         <NA>         This is an important    4    ins
    ## 36   NA    2                         <NA>            notice! It should    4    ins
    ## 37   NA    3                         <NA>      therefore be located at    4    ins
    ## 38   NA    4                         <NA>        the beginning of this    4    ins
    ## 39   NA    6                         <NA>                                NA ignore
    ## 40   NA   14                         <NA>           compress anything.    2    ins
    ## 41   NA   15                         <NA>                                NA ignore
    ## 42   NA   25                         <NA>                                NA ignore
    ## 43   NA   27                         <NA>      important new additions    3    ins
    ## 44   NA   28                         <NA>            to this document.    3    ins
    ## 45   NA   29                         <NA>                                NA ignore
