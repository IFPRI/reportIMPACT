#' reportSupply
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportSupply(gdx)}
#' @export

reportSupply <- function(gdx){
  df <- supply(gdx = gdx)
  df$indicator <- "Supply"

  df <- clean_description(df)

  return(df)
}
