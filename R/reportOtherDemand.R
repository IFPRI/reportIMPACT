#' reportOtherDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportOtherDemand(gdx)}
#' @export

reportOtherDemand <- function(gdx) {
  df <- otherDemand(gdx = gdx)
  df$indicator <- "Other demand"

  df <- clean_description(df)

  return(df)
}
