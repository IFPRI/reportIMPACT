#' reportImportShareDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportImportShareDemand(gdx)}
#' @export

reportImportShareDemand <- function(gdx, ...) {
  df <- ImportShareDemand(gdx = gdx, ...)
  df$indicator <- "Import Share of Demand"

  df <- clean_description(df)

  return(df)
}
