#' reportHouseholdDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHouseholdDemand(gdx)}
#' @export

reportHouseholdDemand <- function(gdx, ...) {
  df <- householdDemand(gdx = gdx, ...)
  df$indicator <- "Household demand"

  df <- clean_description(df)

  return(df)
}
