#' reportProduction
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportProduction(gdx)}
#' @export

reportProduction <- function(gdx) {
  df <- production(gdx = gdx)
  df$indicator <- "Production"

  df <- clean_description(df)

  return(df)
}
