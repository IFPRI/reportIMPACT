#' animals
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO animals
#'
#' @import DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- animals(gdx)}
#' @export

animals <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "ANMLNUMCTYX0"))
  return(df)
}
