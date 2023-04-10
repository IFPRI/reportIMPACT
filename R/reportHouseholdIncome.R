#' reportHouseholdIncome
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHouseholdIncome(gdx)}
#' @export

reportHouseholdIncome <- function(gdx){
  df <- householdIncome(gdx = gdx)
  df$indicator <- "Household Income"

  df <- clean_description(df)

  return(df)
}
