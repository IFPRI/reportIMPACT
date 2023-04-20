#' reportNetTrade
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO NetExport
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportNetExport(gdx)}
#' @export

reportNetTrade <- function(gdx) {
  df <- netTrade(gdx = gdx)
  df$indicator <- "Net Trade"

  df <- clean_description(df)

  return(df)
}
