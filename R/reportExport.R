#' reportExport
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO export
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportexport(gdx)}
#' @export

reportExport <- function(gdx, ...) {
  df <- export(gdx = gdx, ...)
  df$indicator <- "Export"

  df <- clean_description(df)

  return(df)
}
