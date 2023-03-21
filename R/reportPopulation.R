#' reportPopulation
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gdxrrw DOORMAT
#' @importFrom dplyr group_by summarise %>%
#' @importFrom rlang .data
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportPopulation(gdx)}
#' @export

reportPopulation <- function(gdx){
  df <- population(gdx = gdx)
  df$indicator <- "Population"

  df <- clean_description(df)

  return(df)
}
