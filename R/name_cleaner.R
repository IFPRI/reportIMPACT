#' Name Cleaner
#'
#' @param df placeholder dataframe for cleanup
#' @param fix_only_na if only NA as character in cols should be fixed
#'
#' @return cleaned dataframe with right names
#' @export
#'
#' @examples
#' \dontrun{x <- name_cleaner(df)}
#' @export

name_cleaner <- function(df, fix_only_na = FALSE) {

  nums <- unlist(sapply(df, is.numeric), use.names = FALSE)

  df <- as.data.frame(df)

  for (cols in colnames(df)[!nums]) {
    df[, cols] <- gsub(pattern = "\\<NA\\>", replacement = NA, x = df[, cols])
  }

  if (fix_only_na) {
    return(df)
    stop()
  }

  if (is.element("groups", colnames(df))) {
    df$indicator <- paste(df$indicator, df$groups, sep = "|")
  }

  if (is.element("long_name", colnames(df))) {
    df$indicator <- paste(df$indicator, df$long_name, sep = "|")
  }

  if (is.element("h", colnames(df))) {
    df$indicator <- paste(df$indicator, df$h, sep = "|")
  }

  if (is.element("fctr", colnames(df))) {
    df$fctr <- gsub(pattern = "air", replacement = "Irrigated", x = df$fctr)
    df$fctr <- gsub(pattern = "arf", replacement = "Rainfed", x = df$fctr)

    df$fctr <- gsub(pattern = "gir", replacement = "Irrigated grass",
                    x = df$fctr)
    df$fctr <- gsub(pattern = "grf", replacement = "Rainfed grass", x = df$fctr)

    df$fctr <- gsub(pattern = "flbr", replacement = "Labor", x = df$fctr)
    df$fctr <- gsub(pattern = "fert", replacement = "Fertilizer", x = df$fctr)

    df$indicator <- paste(df$indicator, df$fctr, sep = "|")
  }

  if (is.element("lnd", colnames(df))) {
    df$fctr <- gsub(pattern = "air", replacement = "Irrigated", x = df$lnd)
    df$fctr <- gsub(pattern = "arf", replacement = "Rainfed", x = df$lnd)

    df$fctr <- gsub(pattern = "gir", replacement = "Irrigated grass",
                    x = df$lnd)
    df$fctr <- gsub(pattern = "grf", replacement = "Rainfed grass", x = df$lnd)

    df$indicator <- paste(df$indicator, df$lnd, sep = "|")
  }

  df$indicator <- gsub(pattern = "\\|NA", replacement = "", x = df$indicator)

  return(df)
}
