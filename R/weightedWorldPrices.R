#' World Prices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO weightedWorldPrices
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie getSets getNames dimSums getItems
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- weightedWorldPrices(gdx)}
#' @export

weightedWorldPrices <- function(gdx, ...) {
  `getItems` <- NULL

  prices <- as.magpie(readGDX(gdx = gdx, name = "PWX0")[["data"]],
                      spatial = "cty",
                      temporal = "yrs")
  demand <- as.magpie(readGDX(gdx = gdx, name = "QDX0")[["data"]],
                      spatial = "cty",
                      temporal = "yrs")

  # At this stage, the unit is 000 2005 USD but later
  # will be divided by 000 mt so okay to keep unit as 2005 USD per mt here
  value <- dimSums(prices
                   *
                     collapseNames(demand[, , getItems(prices, dim = "c")]),
                   dim = 1, na.rm = TRUE)
  value <- as.data.frame(value)[-1]

  colnames(value) <- c(getSets(prices), "value")
  colnames(value)[colnames(value) == "region"] <- "cty"
  value$cty <- "GLO"

  pass_list <- list()
  pass_list[["data"]] <- value
  pass_list[["domains"]] <- c("c", "cty")

  value_aggregate <- aggregateIMPACT(df = pass_list, ...)
  value_aggregate <- levelSum(df = value_aggregate, dim_name = "long_name")

  demand_aggregate <- aggregateIMPACT(
    df = readGDX(gdx = gdx, name = "QDX0"),
    ...)
  demand_aggregate <- levelSum(df = demand_aggregate, dim_name = "long_name")

  value_agg_mag <- as.magpie(value_aggregate)
  demand_agg_mag <- as.magpie(demand_aggregate, spatial = "region")

  magclass::getItems(demand_agg_mag, dim = 3.1) <-
    getItems(value_agg_mag, dim = 3.1)

  price_aggregate <- value_agg_mag / demand_agg_mag[, , getNames(value_agg_mag)]

  df <- as.data.frame(price_aggregate)[-1]

  colnames(df) <- c(getSets(as.magpie(value_agg_mag)), "value")
  df <- name_cleaner(df = df, fix_only_na = TRUE)

  return(df)
}
