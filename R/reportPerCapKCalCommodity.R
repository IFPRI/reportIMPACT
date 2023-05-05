#' reportPerCapKCalCommodity
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO FoodAvailability
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPerCapKCalCommodity(gdx)}
#' @export

reportPerCapKCalCommodity <- function(gdx, ...) {
  df <- PerCapKCalCommodity(gdx = gdx, ...)
  df$indicator <- "KCal per Capita per commodity"

  df <- clean_description(df)

  return(df)
}
