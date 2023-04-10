#' netTrade
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO netExport
#'
#' @import DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- netExport(gdx)}
#' @export

netTrade <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QNX0"))
  return(df)
}
