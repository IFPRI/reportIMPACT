#' lsfDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO lsfDemand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- lsfDemand(gdx)}
#' @export

lsfDemand <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QLX0"))
  return(df)
}
