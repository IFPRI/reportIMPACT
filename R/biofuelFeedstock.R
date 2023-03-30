#' biofuelFeedstock
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO biofuelFeedstock
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- biofuelFeedstock(gdx)}
#' @export

biofuelFeedstock <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QBFX0"))
  return(df)
}
