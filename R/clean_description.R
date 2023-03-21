#' clean_description
#'
#' @param df dataframe with description column
#'
#' @return GLO population
#'
#' @import gdxrrw DOORMAT
#' @importFrom dplyr group_by summarise %>%
#' @importFrom rlang .data
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- clean_description(df)}
#' @export

clean_description <- function(df){
  x <- NULL
  df$unit         <- sapply(strsplit(df$description, '[()]'), function(x) x[[2]])

  df$description   <- sapply(strsplit(df$description, ' [()]'), function(x) x[[1]])
  return(df)
}
