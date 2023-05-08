#' reportNetTradeShareDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportNetTradeShareDemand(gdx)}
#' @export

reportNetTradeShareDemand <- function(gdx, ...) {
  df <- NetTradeShareDemand(gdx = gdx, ...)
  df$indicator <- "Net trade Share of Demand"

  df <- clean_description(df)

  return(df)
}
