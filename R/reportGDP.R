#' reportGDP
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportGDP(gdx)}
#' @export

reportGDP <- function(gdx, ...) {
  df <- GDP(gdx = gdx, ...)
  df$indicator <- "GDP"

  df <- clean_description(df)

  return(df)
}
