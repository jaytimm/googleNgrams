#' Get file links
#'
#' @name gram_get_links
#' @return A data frame
#'
#'
#' @export
#' @rdname gram_get_links
#'
#'
gram_get_links <- function(){

  gurl <- 'https://storage.googleapis.com/books/ngrams/books/datasetsv3.html'
  link <- gurl |> rvest::read_html(gurl) |>
    rvest::html_nodes("a") |>
    rvest::html_attr('href')

  df <- data.frame(link)
  df0 <- subset(df, grepl('gz|zip|txt', link))
  df0$type <- gsub('http.*/', '', df0$link)

  df1 <- subset(df0, grepl('^google', type))

  suppressWarnings(
    foo <- data.frame(do.call('rbind',
                              strsplit(as.character(df1$link), '-', fixed=TRUE)))
  )

  foo$language <- ifelse(foo$X3 == 'all', foo$X2, paste0(foo$X2, '-', foo$X3))
  foo$ngram <- ifelse(foo$X3 %in% c('all', '1M'), foo$X4, foo$X5)
  foo$date <- ifelse(foo$X3 %in% c('all', '1M'), foo$X5, foo$X6)

  foo$link <- df1$link
  foo1 <- foo[, c('link', 'language', 'ngram', 'date')]
  foo2 <- unique(foo1)

  foo2020 <- gram_get_links2020()

  foo3 <- rbind(foo2, foo2020)
  foo3 <-foo3[order(foo3$date, foo3$ngram, foo3$language), ]
  subset(foo3, !grepl('txt', link))
}

