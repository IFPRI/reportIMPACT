#' reportMalnourished
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO Malnourished
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportMalnourished(gdx)}
#' @export

reportMalnourished <- function(gdx, ...) {
  df <- malnourished(gdx = gdx, ...)
  df$indicator <- "Malnourished Children"

  df <- clean_description(df)

  return(df)
}
