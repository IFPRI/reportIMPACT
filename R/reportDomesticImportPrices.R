#' reportDomesticImportPrices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportDomesticImportPrices(gdx)}
#' @export

reportDomesticImportPrices <- function(gdx, ...) {
  df <- DomesticImportPrices(gdx = gdx, ...)
  df$indicator <- "Domestic Import Prices"

  df <- clean_description(df)

  return(df)
}
