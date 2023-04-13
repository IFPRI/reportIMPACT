#' netTrade
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO netExport
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- netExport(gdx)}
#' @export

netTrade <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QNX0"))
  df <- levelSum(df = df,dim_name = "long_name")
  return(df)
}
