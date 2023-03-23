#' cropArea
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO cropArea
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- cropArea(gdx)}
#' @export

cropArea <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "AREACTYX0"))
  return(df)
}
