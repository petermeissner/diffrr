
devtools::install_github("petermeissner/diffr", ref="going-for-version-0.1.2")
require(diffr)

res <- diffr(   example_A1_split,     # example text
                example_A2_split,     # example text
                clean = "none",       # text cleaning function [option or function]
                dist = "levenwords",  # distance function      [option or function]
                maxDist = "Inf",      # max distance acceptable for a match ["10%", "20"]
            )

# resulting alignment of text
res$alignment_df

# texts
res$text1_orig
res$text2_orig

# what else ... 
names(res)