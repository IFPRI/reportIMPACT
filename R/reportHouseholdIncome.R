#' reportHouseholdIncome
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHouseholdIncome(gdx)}
#' @export

reportHouseholdIncome <- function(gdx, ...) {
  df <- householdIncome(gdx = gdx, ...)
  df$indicator <- "Household Income"

  df <- clean_description(df)

  return(df)
}
