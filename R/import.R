#' import
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO import
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- import(gdx)}
#' @export

import <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QMX0"))
  return(df)
}
