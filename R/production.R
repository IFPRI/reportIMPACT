#' Production
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Production
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- Production(gdx)}
#' @export

production <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QSX0"))
  return(df)
}
