#' export
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO export
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- export(gdx)}
#' @export

export <- function(gdx) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QEX0"))
  df <- levelSum(df = df, dim_name = "long_name")
  return(df)
}
