#' reportGDP
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportGDP(gdx)}
#' @export

reportGDP <- function(gdx){
  df <- GDP(gdx = gdx)
  df$indicator <- "GDP"

  df <- clean_description(df)

  return(df)
}