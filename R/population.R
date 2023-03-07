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
  var <- gdxrrw::rgdx.param(gdxName = gdx, "p_POP_opt")
  colnames(var)[length(colnames(var))] <- "value"
  df <- var %>%
    group_by(YRS) %>%
    summarise(value = sum(value))
  df$identifier <- gsub(pattern = ".gdx",replacement = "",x = basename(gdx))
  df$source <- "IMPACT"
  out <- as.data.frame(df)
  return(out)
}
