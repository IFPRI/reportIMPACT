#' reportHungerRisk
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHungerRisk(gdx)}
#' @export

reportHungerRisk <- function(gdx){
  df <- hungerRisk(gdx = gdx)
  df$indicator <- "Population at hunger risk"

  df <- clean_description(df)

  return(df)
}
