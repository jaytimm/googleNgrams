#' Convert ngram output to dtm
#'
#' @name gram_build_dtm
#' @param x A data frame
#' @return A data frame
#'
#'
#' @export
#' @rdname gram_build_dtm
#'
#'
gram_build_dtm <- function(x){
  x[, ngram := text]
  x1 <- x[, lapply(.SD, function(x) unlist(data.table::tstrsplit(x, " "))),
          .SDcols = "text", by = c("ngram", "time", "freq")]
  x1[, token_id := data.table::rowid(ngram)]
  return(x1)
}
