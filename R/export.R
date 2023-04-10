#' export
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO export
#'
#' @import DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- export(gdx)}
#' @export

export <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QEX0"))
  return(df)
}
