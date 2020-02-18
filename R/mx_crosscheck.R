#' Live check against medRxiv
#' @description Cross-check whether the dataset you are using is current
#' @examples \dontrun{
#' mx_crosscheck()
#' }
#' @export


mx_crosscheck <- function(){

  page <- xml2::read_html("https://www.medrxiv.org/search/%252A")

  reference <- page %>%
    rvest::html_nodes("#page-title") %>%
    rvest::html_text()

  reference <- gsub(",","",reference)

  reference <- as.numeric(stringr::word(reference))

  data <- mx_search("*")

  data$link <- gsub("\\?versioned=TRUE","", data$link)

  data$link <- substr(data$link,1,nchar(data$link)-2)

  extracted <- as.numeric(length(unique(data$link)))

  if (identical(reference,extracted)==TRUE) {
    message("Data is current.")
  } else {
    message("Data is out of date.")
  }
}