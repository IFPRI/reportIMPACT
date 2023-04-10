#' householdDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO householdDemand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- householdDemand(gdx)}
#' @export

householdDemand <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QHDX0"))
  return(df)
}
