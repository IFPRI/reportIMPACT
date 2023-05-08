#' reportNetTradeShareProduction
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportNetTradeShareProduction(gdx)}
#' @export

reportNetTradeShareProduction <- function(gdx, ...) {
  df <- NetTradeShareProduction(gdx = gdx, ...)
  df$indicator <- "Net trade Share of Production"

  df <- clean_description(df)

  return(df)
}
