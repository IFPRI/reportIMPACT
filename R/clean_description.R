#' clean_description
#'
#' @param df dataframe with description column
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- clean_description(df)}
#' @export

clean_description <- function(df){
  x <- NULL
  if(is.factor(df$description)) df$description <- as.character(df$description)

  df$unit         <- sapply(strsplit(df$description, '[()]'), function(x) x[[2]])

  df$description   <- sapply(strsplit(df$description, ' [()]'), function(x) x[[1]])

  if(is.element("groups", colnames(df))){
    df$indicator <- paste(df$indicator,df$groups,sep = "|")
  }

  if(is.element("long_name", colnames(df))){
    df$indicator <- paste(df$indicator,df$long_name,sep = "|")
  }

  return(df)
}
