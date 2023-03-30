#' householdIncome
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO householdIncome
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- householdIncome(gdx)}
#' @export

householdIncome <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "GDPHX0"))
  return(df)
}
