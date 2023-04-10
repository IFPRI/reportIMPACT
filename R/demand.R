#' Demand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Demand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- Demand(gdx)}
#' @export

demand <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QDX0"))
  return(df)
}
