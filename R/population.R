#' Population
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#' @export
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
  out <- as.data.frame(df)
  return(out)
}