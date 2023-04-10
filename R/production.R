#' Production
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Production
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- Production(gdx)}
#' @export

production <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QSX0"))

  df_mag <- as.magpie(df)
  trade_sets <- grep(pattern = "raded",x = getNames(df_mag),value = TRUE)
  traded_agg <- df_mag[,,trade_sets]
  traded_agg <- add_dimension(x = dimSums(x = traded_agg,dim = "groups",na.rm = TRUE),add = "groups",nm = "Combined",dim = 3.3)

  df <- mbind(df_mag,traded_agg)

  df <- as.data.frame(df)[-1]

  colnames(df) <- c(getSets(df_mag),"value")

  return(df)
}
