#' GDP
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO GDP
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- GDP(gdx)}
#' @export

GDP <- function(gdx, ...) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "GDPX0"), ...)
  return(df)
}
