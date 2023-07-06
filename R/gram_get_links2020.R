#' Get file links
#'
#' @name gram_get_links2020
#' @return A data frame
#'
#'
#' @export
#' @rdname gram_get_links2020
#'
#'
gram_get_links2020 <- function(){

  lapply(1:5, function(x){
    link <- paste0('https://storage.googleapis.com/books/ngrams/books/20200217/eng/eng-', x, '-ngrams_exports.html') |>
      rvest::read_html() |>
      rvest::html_nodes("a") |>
      rvest::html_attr('href')

    df <- data.frame(link)
    df0 <- subset(df, grepl('gz|zip|txt', link))
    # df0$type <- gsub('http.*/', '', df0$link)
    df0$language <- 'eng'
    df0$ngram <- paste0(x, 'gram')
    df0$date <- '20200217'

    return(df0)
  }) |>
    data.table::rbindlist()
}
