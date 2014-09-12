# NotDiff 
Comparing text -- but not like diff

## Description


A package for measuring change between different versions of text by automatically
or semi-automatically aligning text lines and measuring the change. It works kind of like diff
or version control systems but focuses on **measuring** the **change** in contrast to focusing on
solid version control. Furthermore, the package allows for (possibly user made) text cleaning
functions that are applied before comparison. Another feature is the semi-automatic alignment
that allows for fast computer decissions on clear alignments of 100% matches and 0% matches
while asking for human input on more complex decissions.
  

## Installation and Demonstration


    require(devtools)
    install_github("petermeissner/NotDiff")
    require(NotDiff)

    
## Links

- http://www.polver.uni-konstanz.de/sieberer/forschung/

