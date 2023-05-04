#' reportPerCapKCal
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO FoodAvailability
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPerCapKCal(gdx)}
#' @export

reportPerCapKCal <- function(gdx, ...) {
  df <- PerCapKCal(gdx = gdx, ...)
  df$indicator <- "KCal per Capita"

  df <- clean_description(df)

  return(df)
}
