#' reportPerCapGDP
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPerCapGDP(gdx)}
#' @export

reportPerCapGDP <- function(gdx, ...) {
  df <- percapGDP(gdx = gdx, ...)
  df$indicator <- "GDP per Capita"

  df <- clean_description(df)

  return(df)
}
