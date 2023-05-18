#' Domestic Export Prices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO DomesticExportPrices
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie getSets getNames dimSums getItems
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- DomesticExportPrices(gdx)}
#' @export

DomesticExportPrices <- function(gdx, ...) {

  prices <- as.magpie(readGDX(gdx = gdx, name = "PEX0")[["data"]],
                      spatial = "cty", temporal = "yrs")
  demand <- as.magpie(readGDX(gdx = gdx, name = "QDX0")[["data"]],
                      spatial = "cty", temporal = "yrs")

  # At this stage, the unit is 000 2005 USD but later will be divided by 000 mt
  # so okay to keep unit as 2005 USD per mt here
  value <-
    prices[getRegions(demand), , ] *
    collapseNames(demand[, , getItems(prices, dim = "c")])

  value[is.na(value)] <- 0

  value <- as.data.frame(value)[-1]

  colnames(value) <- c(getSets(prices), "value")

  pass_list <- list()
  pass_list[["data"]] <- value
  pass_list[["domains"]] <- c("c", "cty")

  value_aggregate <- aggregateIMPACT(df = pass_list, ...)
  value_aggregate <- levelSum(df = value_aggregate, dim_name = "long_name")
  value_mag <- as.magpie(value_aggregate)

  demand_aggregate <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QDX0"),
                                      ...)
  demand_aggregate <- levelSum(df = demand_aggregate, dim_name = "long_name")
  demand_mag <- collapseNames(as.magpie(demand_aggregate))

  common_elements <-
    intersect(getNames(collapseNames(value_mag)), getNames(demand_mag))

  price_aggregate <- value_mag / demand_mag[, , common_elements]

  df <- as.data.frame(price_aggregate)[-1]

  colnames(df) <- c(getSets(as.magpie(value_aggregate)), "value")
  df <- name_cleaner(df = df, fix_only_na = TRUE)

  return(df)
}
