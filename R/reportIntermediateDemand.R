#' reportIntermediateDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportIntermediateDemand(gdx)}
#' @export

reportIntermediateDemand <- function(gdx) {
  df <- intermediateDemand(gdx = gdx)
  df$indicator <- "Intermediate Demand"

  df <- clean_description(df)

  return(df)
}
