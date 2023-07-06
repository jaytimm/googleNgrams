# googleNgrams

Download and sample Google ngrams.

## Installation

You can download the development version from GitHub with:

``` r
remotes::install_github("jaytimm/googleNgrams")
```

## Get ngram urls

``` r
links <- googleNgrams::gram_get_links()
five_us <- subset(links, ngram == '5gram' & language == 'eng-1M')
links2020 <- googleNgrams::gram_get_links2020()
links2020 |> head()
```

    ##                                                                                 link
    ## 1: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00000-of-00024.gz
    ## 2: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00001-of-00024.gz
    ## 3: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00002-of-00024.gz
    ## 4: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00003-of-00024.gz
    ## 5: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00004-of-00024.gz
    ## 6: http://storage.googleapis.com/books/ngrams/books/20200217/eng/1-00005-of-00024.gz
    ##    language ngram     date
    ## 1:      eng 1gram 20200217
    ## 2:      eng 1gram 20200217
    ## 3:      eng 1gram 20200217
    ## 4:      eng 1gram 20200217
    ## 5:      eng 1gram 20200217
    ## 6:      eng 1gram 20200217

## Download, unzip

``` r
## options(timeout = 500)
x <- five_us$link[1] |> googleNgrams::gram_get_unzip()
x |> dplyr::sample_n(5) |> knitr::kable()
```

| V1                  |   V2 |  V3 |  V4 |  V5 |
|:--------------------|-----:|----:|----:|----:|
| “of Homer           | 1912 |   1 |   1 |   1 |
| “as a foreign devil | 1918 |   1 |   1 |   1 |
| “our country        | 1986 |   3 |   3 |   3 |
| ”                   | 1903 |   3 |   3 |   3 |
| a total dose of 2   | 2004 |   1 |   1 |   1 |

## Sample

``` r
x1 <- x |>
  googleNgrams::gram_sample_ngram(start_date = 1808,
                                  end_date = 2008, 
                                  generation = 25,
                                  samp = 100000)   

x1 |> head() |> knitr::kable()
```

| text                        | time         | freq |
|:----------------------------|:-------------|-----:|
| set out about nine in       | \[1808,1833) |    2 |
| persons may be said to      | \[1933,1958) |    2 |
| to comply strictly with all | \[1833,1858) |    1 |
| is found in egg yolk        | \[1933,1958) |    5 |
| dealt his blows with as     | \[1858,1883) |    3 |
| in the production of dyes   | \[1908,1933) |    4 |

## As document-term

``` r
x1 |> googleNgrams::gram_build_dtm() |> head() |> knitr::kable()
```

| ngram                  | time         | freq | text    | token_id |
|:-----------------------|:-------------|-----:|:--------|---------:|
| set out about nine in  | \[1808,1833) |    2 | set     |        1 |
| set out about nine in  | \[1808,1833) |    2 | out     |        2 |
| set out about nine in  | \[1808,1833) |    2 | about   |        3 |
| set out about nine in  | \[1808,1833) |    2 | nine    |        4 |
| set out about nine in  | \[1808,1833) |    2 | in      |        5 |
| persons may be said to | \[1933,1958) |    2 | persons |        1 |

## Workflow

``` r
output_dir <- '/home/jtimm/Desktop/google-ngrams/'
  
for (i in 1:nrow(five_us)){
  
  x <- five_us$link[i] |> googleNgrams::gram_get_unzip()

  x1 <- x |>
    googleNgrams::gram_sample_ngram(start_date = 1808,
                                    end_date = 2008,
                                    generation = 25,
                                    samp = 100000)   
  
  x2 <- x1 |> googleNgrams::gram_build_dtm()
  
  
  
  setwd(output_dir )
  saveRDS(x2, paste0('g', i, '.rds'))
}
```

## Summary
