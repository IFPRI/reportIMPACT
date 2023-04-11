#' Intermediate Demand
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO other Demand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- intermediateDemand(gdx)}
#' @export

intermediateDemand <- function(gdx){
  df <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QINTX0"))

  # Traded / Non traded Fix

  df_mag <- as.magpie(df)
  trade_sets <- grep(pattern = "raded",x = getNames(df_mag),value = TRUE)
  traded_agg <- df_mag[,,trade_sets]
  traded_agg <- add_dimension(x = dimSums(x = traded_agg,dim = "groups",na.rm = TRUE),add = "groups",nm = "Combined Oilseeds",dim = 3.3)

  # Sugar Fix

  sugar_sets <- grep(pattern = "Sugar Crops",x = getNames(df_mag),value = TRUE)
  sugar_agg <- df_mag[,,sugar_sets]
  sugar_agg <- add_dimension(x = dimSums(x = sugar_agg,dim = "long_name",na.rm = TRUE),add = "long_name",nm = "Combined Sugar Crops",dim = 3.4)

  # Bind

  df <- mbind(df_mag,traded_agg,sugar_agg)



  df <- as.data.frame(df)[-1]

  colnames(df) <- c(getSets(df_mag),"value")

  return(df)
}
