#' reportPopulation
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPopulation(gdx)}
#' @export

reportPopulation <- function(gdx){
  df <- population(gdx = gdx)
  df$indicator <- "Population"

  df <- clean_description(df)

  return(df)
}
