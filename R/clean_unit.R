#' Clean unit
#'
#' @param df dataframe with description column
#'
#' @return Converted units if needed
#'
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- clean_unit(df)}
#' @export

clean_unit <- function(df) {

  new_unit <- unit <- unique(df$unit)

  if (unit == "millions") new_unit <- "million"
  if (grepl(pattern = "000", x = unit)) {
    new_unit <- gsub(pattern = "000", replacement = "million", x = unit)
    df$value <- df$value / 1e3
  }

  df$unit <- new_unit

  return(df)
}
