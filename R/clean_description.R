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

  if(is.element("h", colnames(df))){
    df$indicator <- paste(df$indicator,df$h,sep = "|")
  }

  if(is.element("fctr", colnames(df))){
    df$fctr <- gsub(pattern = "air",replacement = "Irrigated",x = df$fctr)
    df$fctr <- gsub(pattern = "arf",replacement = "Rainfed",x = df$fctr)

    df$fctr <- gsub(pattern = "gir",replacement = "Irrigated grass",x = df$fctr)
    df$fctr <- gsub(pattern = "grf",replacement = "Rainfed grass",x = df$fctr)

    df$fctr <- gsub(pattern = "flbr",replacement = "Labor",x = df$fctr)
    df$fctr <- gsub(pattern = "fert",replacement = "Fertilizer",x = df$fctr)

    df$indicator <- paste(df$indicator,df$fctr,sep = "|")
  }

  if(is.element("lnd", colnames(df))){
    df$fctr <- gsub(pattern = "air",replacement = "Irrigated",x = df$lnd)
    df$fctr <- gsub(pattern = "arf",replacement = "Rainfed",x = df$lnd)

    df$fctr <- gsub(pattern = "gir",replacement = "Irrigated grass",x = df$lnd)
    df$fctr <- gsub(pattern = "grf",replacement = "Rainfed grass",x = df$lnd)

    df$indicator <- paste(df$indicator,df$lnd,sep = "|")
  }

  return(df)
}
