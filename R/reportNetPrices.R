#' reportNetPrices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return Solution Net Prices
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportNetPrices(gdx)}
#' @export

reportNetPrices <- function(gdx, ...) {
  df <- NetPrices(gdx = gdx, ...)
  df$indicator <- "Net Prices"

  df <- clean_description(df)

  return(df)
}
