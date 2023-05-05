#' reportExportShareProduction
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportExportShareProduction(gdx)}
#' @export

reportExportShareProduction <- function(gdx, ...) {
  df <- ExportShareProduction(gdx = gdx, ...)
  df$indicator <- "Export Share of Production"

  df <- clean_description(df)

  return(df)
}
