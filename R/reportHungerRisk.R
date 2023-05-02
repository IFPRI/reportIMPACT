#' reportHungerRisk
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHungerRisk(gdx)}
#' @export

reportHungerRisk <- function(gdx, ...) {
  df <- hungerRisk(gdx = gdx, ...)
  df$indicator <- "Population at hunger risk"

  df <- clean_description(df)

  return(df)
}
