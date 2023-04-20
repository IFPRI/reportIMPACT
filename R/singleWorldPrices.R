#' Single World Prices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO singleWorldPrices
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie add_dimension
#' getSets getNames dimSums mbind getRegions
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- singleWorldPrices(gdx)}
#' @export

singleWorldPrices <- function(gdx) {
  df <- readGDX(gdx = gdx, name = "PWX0")
  df[["data"]]$cty <- "GLO"
  df[["domains"]] <- c("c", "cty")
  df <- aggregateIMPACT(df = df)

  return(df)
}
