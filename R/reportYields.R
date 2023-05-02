#' reportYields
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO Yield
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportYield(gdx)}
#' @export

reportYields <- function(gdx, ...) {
  df <- yields(gdx = gdx, ...)
  df$indicator <- "Aggregated Yield"

  df <- clean_description(df)

  return(df)
}
