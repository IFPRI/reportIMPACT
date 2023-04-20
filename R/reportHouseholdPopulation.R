#' reportHouseholdPopulation
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO population
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportHouseholdPopulation(gdx)}
#' @export

reportHouseholdPopulation <- function(gdx) {
  df <- householdPopulation(gdx = gdx)
  df$indicator <- "Household Population"

  df <- clean_description(df)

  return(df)
}
