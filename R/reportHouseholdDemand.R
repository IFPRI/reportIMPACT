#' reportHouseholdDemand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHouseholdDemand(gdx)}
#' @export

reportHouseholdDemand <- function(gdx){
  df <- householdDemand(gdx = gdx)
  df$indicator <- "Household demand"

  df <- clean_description(df)

  return(df)
}
