#' reportAnimals
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Animals
#'
#' @import gdxrrw DOORMAT
#' @importFrom dplyr group_by summarise %>%
#' @importFrom rlang .data
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportAnimals(gdx)}
#' @export

reportAnimals <- function(gdx){
  df <- animals(gdx = gdx)
  df$indicator <- "Animals"

  df <- clean_description(df)

  # lvsys is same across all set elements, pick any one

  df <- df[df$lvsys %in% unique(df$lvsys)[1],]
  df$indicator <- paste(df$indicator,df$groups,df$long_name,sep = "|")

  return(df)
}
