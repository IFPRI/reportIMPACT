#' reportDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportDemand(gdx)}
#' @export

reportDemand <- function(gdx, ...) {
  df <- demand(gdx = gdx, ...)
  df$indicator <- "Demand"

  df <- clean_description(df)

  return(df)
}
