#' reportWeightedWorldPrices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportWeightedWorldPrices(gdx)}
#' @export

reportWeightedWorldPrices <- function(gdx, ...) {
  df <- weightedWorldPrices(gdx = gdx, ...)
  df$indicator <- "Aggregated World Prices"

  df <- clean_description(df)

  return(df)
}
