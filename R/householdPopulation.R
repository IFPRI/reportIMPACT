#' householdPopulation
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO householdPopulation
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- householdPopulation(gdx)}
#' @export

householdPopulation <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "POPHX0"))
  return(df)
}
