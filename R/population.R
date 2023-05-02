#' Population
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- population(gdx)}
#' @export

population <- function(gdx, ...) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "POPX0"), ...)
  return(df)
}
