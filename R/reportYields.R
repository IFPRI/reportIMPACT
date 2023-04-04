#' reportYields
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Yield
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportYield(gdx)}
#' @export

reportYields <- function(gdx){
  df <- yields(gdx = gdx)
  df$indicator <- "Aggregated Yield"

  df <- clean_description(df)

  return(df)
}