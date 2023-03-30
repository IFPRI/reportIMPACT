#' GDP
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO GDP
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- GDP(gdx)}
#' @export

GDP <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "GDPX0"))
  return(df)
}
