#' Sample, filter ngram dtm
#'
#' @name gram_sample_ngram
#' @param x A data frame
#' @param start_date An integer
#' @param end_date An integer
#' @param seed An integer
#' @param generation An integer
#' @param remove_nonalpha A boolean
#' @param tolower A boolean
#' @param sample An integer
#' @return A list
#'
#'
#' @export
#' @rdname gram_sample_ngram
#'
#'
gram_sample_ngram <- function (x,
                               start_date,
                               end_date,
                               seed = 99,
                               generation = 25,
                               remove_nonalpha = T,
                               tolower = T,
                               sample = 500000) {


  x <- x[V2 >= start_date & V2 <= end_date]

  if(remove_nonalpha){
    x <- x[grepl("^[a-z ]+$", V1, ignore.case = TRUE)]
  }

  ## samp1
  set.seed(seed)
  x <- x[sample(1:nrow(x), sample, replace=FALSE),]

  x[, V9 := cut(x$V2,
                seq(start_date, end_date,generation),
                right=FALSE,
                include.lowest = TRUE,
                dig.lab = 4)] #Create new time bins

  if(tolower){x[, V1 := tolower(V1)]}

  # Aggregate freqs to new time bins
  x <- x[, list(V3 = sum(V3)), by = list(V1, V9)]

  data.table::setnames(x,
                       old = c('V1', 'V9', 'V3'),
                       new = c('text', 'time', 'freq'))

  data.table::data.table(x)
}
