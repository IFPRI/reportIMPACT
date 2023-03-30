#' reportDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportDemand(gdx)}
#' @export

reportDemand <- function(gdx){
  df <- demand(gdx = gdx)
  df$indicator <- "Demand"

  df <- clean_description(df)

  return(df)
}
