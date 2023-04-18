#' reportSingleWorldPrices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportSingleWorldPrices(gdx)}
#' @export

reportSingleWorldPrices <- function(gdx){
  df <- singleWorldPrices(gdx = gdx)
  df$indicator <- "World prices"

  df <- clean_description(df)

  return(df)
}
