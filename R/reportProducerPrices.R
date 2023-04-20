#' reportProducerPrices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportproducerPrices(gdx)}
#' @export

reportProducerPrices <- function(gdx) {
  df <- producerPrices(gdx = gdx)
  df$indicator <- "producer Prices"

  df <- clean_description(df)

  return(df)
}
