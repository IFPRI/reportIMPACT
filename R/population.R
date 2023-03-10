#' Population
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gdxrrw
#' @importFrom dplyr group_by summarise %>%
#' @importFrom rlang .data
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- population(gdx)}
#' @export

population <- function(gdx){
  df <- rgdx.param(gdxName = gdx, "PopX0")
  colnames(df)[length(colnames(df))] <- "value"
  df <- df %>%
    group_by(.data$YRS) %>%
    summarise(value = sum(.data$value))
  df$identifier <- gsub(pattern = ".gdx",replacement = "",x = basename(gdx))
  df$model <- "IMPACT"
  df$variable <- "Population"
  df$unit <- "million capita"
  out <- as.data.frame(df)
  return(out)
}
