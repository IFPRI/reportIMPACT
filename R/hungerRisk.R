#' hungerRisk
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO hungerRisk
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- hungerRisk(gdx)}
#' @export

hungerRisk <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "PopulationAtRisk"))
  return(df)
}
