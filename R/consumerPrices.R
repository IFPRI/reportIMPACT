#' Consumer Prices
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO consumerPrices
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie add_dimension
#' getSets getNames dimSums mbind getRegions
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- consumerPrices(gdx)}
#' @export

consumerPrices <- function(gdx, ...) {
  prices <- as.magpie(readGDX(gdx = gdx, name = "PCX0")[["data"]],
                      spatial = "cty", temporal = "yrs")
  demand <- as.magpie(readGDX(gdx = gdx, name = "QDX0")[["data"]],
                      spatial = "cty", temporal = "yrs")

  # At this stage, the unit is 000 2005 USD but later will be divided by 000 mt
  # so okay to keep unit as 2005 USD per mt here
  value <- prices[getRegions(demand), , ] * collapseNames(demand)
  value[is.na(value)] <- 0

  value <- as.data.frame(value)[-1]

  colnames(value) <- c(getSets(prices), "value")

  pass_list <- list()
  pass_list[["data"]] <- value
  pass_list[["domains"]] <- c("c", "cty")

  value_aggregate <- aggregateIMPACT(df = pass_list, ...)
  value_aggregate <- levelSum(df = value_aggregate, dim_name = "long_name")

  demand_aggregate <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QDX0"),
                                      ...)
  demand_aggregate <- levelSum(df = demand_aggregate, dim_name = "long_name")

  price_aggregate <-
    as.magpie(value_aggregate, spatial = "region") /
    collapseNames(as.magpie(demand_aggregate, spatial = "region"))

  df <- as.data.frame(price_aggregate)[-1]

  colnames(df) <- c(getSets(as.magpie(value_aggregate, spatial = "region")),
                    "value")
  df <- name_cleaner(df = df, fix_only_na = TRUE)

  return(df)
}
