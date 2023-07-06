#' Download, unzip ngram file as csv
#'
#' @name gram_get_unzip
#' @param url A character string
#' @param dir A character string
#' @return A list
#'
#'
#' @export
#' @rdname gram_get_unzip
#'
#'
gram_get_unzip <- function (url, dir = tempdir()) {

  temp <- dir
  zip_name <- paste0(temp, '\\', basename(url))
  download.file(url, zip_name,
                quiet = TRUE)
  unzip(zip_name, exdir = temp)
  setwd(temp) ##
  out <- data.table::fread(gsub('\\.zip', '', basename(url)), ## gsub('\\.zip', '', zip_name),
                           blank.lines.skip = TRUE,
                           quote="",
                           encoding = 'UTF-8')

  unlink(temp)
  out}
