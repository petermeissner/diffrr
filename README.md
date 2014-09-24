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

**Although the package is still under developement and features are missing, the present version (0.1.1) should work and can be installed (without of cause any warrenty whatsoever).**

    # require(devtools)
    # install_github("petermeissner/diffr")
    # require(diffr)

    
## Links

- http://www.polver.uni-konstanz.de/sieberer/forschung/


## Example Usage

    library(diffr)

    res <- diffr(example_A1_split, example_A2_split)
    names(res)
    # [1] "text1_orig"       "text2_orig"       "text1_clean"      "text2_clean"      "distance_matrix" 
    # [6] "alignment_matrix" "alignment_df"
    
    res$alignment_df
    #    row col dist
    # 1   10   6    0
    # 2    1   7    0
    # 3    2   8    0
    # 4    3   9    0
    # 5    4  10    0
    # 6    5  11    0
    # 7    6  12    0
    # 8    7  13    0
    # 9    8  14   18
    # 10  15  15    0
    # 11  16  16    0
    # 12  17  17    2
    # 13  18  18    0
    # 14  19  19    0
    # 15  20  20    0
    # 16  21  21    0
    # 17  22  22    0
    # 18  23  23    0
    # 19  24  24    0
    # 20  14  25   11
    # 21  11  26    0
    # 22  12  28   17
    # 23  25  29    0
    # 24  26  30    0
    # 25  27  31    0
    # 26  28  32    0
    # 27  29  33    0
    # 28   9  NA   NA
    # 29  13  NA   NA
    # 30  NA   1   NA
    # 31  NA   2   NA
    # 32  NA   3   NA
    # 33  NA   4   NA
    # 34  NA   5   NA
    # 35  NA  27   NA
    
    
    
    
    
    
    
    
    
    
    
    
    
