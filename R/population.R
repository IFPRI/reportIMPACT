#' Population
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- population(gdx)}
#' @export

population <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "POPX0"))
  return(df)
}
