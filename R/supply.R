#' Supply
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO supply
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- supply(gdx)}
#' @export

supply <- function(gdx) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QSUPX0"))
  df <- levelSum(df = df, dim_name = "long_name")
  return(df)
}
