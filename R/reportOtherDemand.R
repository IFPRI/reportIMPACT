#' reportOtherDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportOtherDemand(gdx)}
#' @export

reportOtherDemand <- function(gdx, ...) {
  df <- otherDemand(gdx = gdx, ...)
  df$indicator <- "Other demand"

  df <- clean_description(df)

  return(df)
}
