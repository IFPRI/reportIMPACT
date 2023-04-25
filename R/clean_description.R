#' clean_description
#'
#' @param df dataframe with description column
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- clean_description(df)}
#' @export

clean_description <- function(df) {

  if (is.factor(df$description)) df$description <- as.character(df$description)

  df$unit <- sapply(strsplit(df$description, "[()]"), function(x) x[[2]])

  df$description  <- sapply(strsplit(
    df$description, " [()]"), function(x) x[[1]])

  df <- name_cleaner(df)

  # Year factor fix

  df$yrs <- as.factor(as.character(df$yrs))

  # Unit fix

  df <- clean_unit(df)

  return(df)
}
