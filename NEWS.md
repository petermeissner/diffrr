# diffr

## diffr 0.1.2

- sorting of alignDF implemented 
- tested on Win7, Win8, Ubuntu, Mac
- some adjustements to the dist measure of lines that were not matched (insertions and deletions): instead of `NA` there will be a distance adequate to an insertion / deletion (distance between a line and an enmpty string)
- adjusted output of `diffr()`: 
    - less is more -- number of outputs reduced to the following: 
        - the original text (`text1_orig` and `text2_orig`)
        - the cleaned up text (`text1_clean` and `text2_clean`)
        - the distance matrix calculated (`distance_matrix`)
        - as well as the alignment in form of a dataframe (`alignment_df`)
- testing functions for `diffr()` with all available (now and in the future) `dist` and `clean` options defined
- turned of `.onLoad()` and `onAttach()` functions in *zzz.r*
- *README.md* now build with *Rmd*-file
- added source of sample text to example texts

## diffr 0.1.1

- first working version of the package with main features implemented:
    * aligning text versions via
        - cleaning text first via 
            * predefined functions (cleaning used in idep project)
            * or user defined function
            * or of cause none
        - computation of distances via different distance functions
            * functions based on length 
            * based on Levenshtein distance (characters or words)
            * based on bag of words approach 
            * approach used in idep project (same as bag of words approach)
        - aligning text lines and identifying:
            * no change
            * change
            * insertion
            * deletion
        
    

