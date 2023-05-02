#' Malnourished
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO malnourished
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- malnourished(gdx)}
#' @export

malnourished <- function(gdx, ...) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,
                                     name = "TotalMalnourished"), ...)
  df$description <- gsub(pattern = "Children\\(millions\\)",
                         replacement = "Children (millions)",
                         x = df$description)

  return(df)
}
