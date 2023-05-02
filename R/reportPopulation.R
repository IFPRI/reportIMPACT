#' reportPopulation
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPopulation(gdx)}
#' @export

reportPopulation <- function(gdx, ...) {
  df <- population(gdx = gdx, ...)
  df$indicator <- "Population"

  df <- clean_description(df)

  return(df)
}
