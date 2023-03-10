#' Population
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#' @export
#'
#' @import dplyr
#'
#' @examples
#' population_glo <- population(gdx)
#' @author Abhijeet Mishra

population <- function(gdx){
  var <- gdxrrw::rgdx.param(gdxName = gdx, "PopX0")
  colnames(var)[length(colnames(var))] <- "value"
  df <- var %>%
    group_by(YRS) %>%
    summarise(value = sum(value))
  df$identifier <- gsub(pattern = ".gdx",replacement = "",x = basename(gdx))
  df$source <- "IMPACT"
  df$variable <- "Population"
  df$unit <- "million capita"
  out <- as.data.frame(df)
  return(out)
}
