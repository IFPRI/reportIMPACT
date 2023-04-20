#' reportFoodAvailability
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO FoodAvailability
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportFoodAvailability(gdx)}
#' @export

reportFoodAvailability <- function(gdx) {
  df <- foodAvailability(gdx = gdx)
  df$indicator <- "Food Availability"

  df <- clean_description(df)

  return(df)
}
