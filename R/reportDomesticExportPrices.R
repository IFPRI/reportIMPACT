#' reportDomesticExportPrices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportDomesticExportPrices(gdx)}
#' @export

reportDomesticExportPrices <- function(gdx, ...) {
  df <- DomesticExportPrices(gdx = gdx, ...)
  df$indicator <- "Domestic Export Prices"

  df <- clean_description(df)

  return(df)
}
