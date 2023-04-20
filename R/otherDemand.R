#' Other Demand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO other Demand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- otherDemand(gdx)}
#' @export

otherDemand <- function(gdx) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QOTHRX0"))
  df <- levelSum(df = df, dim_name = "long_name")
  return(df)
}
