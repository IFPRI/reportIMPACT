#' reportLSFDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportLSFDemand(gdx)}
#' @export

reportLSFDemand <- function(gdx, ...) {
  df <- lsfDemand(gdx = gdx, ...)
  df$indicator <- "Livestock Feed Demand"

  df <- clean_description(df)

  return(df)
}
