#' reportConsumerPrices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportConsumerPrices(gdx)}
#' @export

reportConsumerPrices <- function(gdx, ...) {
  df <- consumerPrices(gdx = gdx, ...)
  df$indicator <- "Consumer Prices"

  df <- clean_description(df)

  return(df)
}
