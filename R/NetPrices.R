#' Net Prices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO NetPrices
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie getSets getNames dimSums getItems
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- NetPrices(gdx)}
#' @export

NetPrices <- function(gdx, ...) {

  prices <- as.magpie(readGDX(gdx = gdx, name = "PNETX0")[["data"]],
                      spatial = "cty", temporal = "yrs")
  quantity <- as.magpie(readGDX(gdx = gdx, name = "QSX0")[["data"]],
                      spatial = "cty", temporal = "yrs")

  # At this stage, the unit is 000 2005 USD but later will be divided by 000 mt
  # so okay to keep unit as 2005 USD per mt here
  value <-
    prices[getRegions(quantity), , ] *
    collapseNames(quantity[, , getItems(prices, dim = "j")])

  value[is.na(value)] <- 0

  value <- as.data.frame(value)[-1]

  colnames(value) <- c(getSets(prices), "value")

  pass_list <- list()
  pass_list[["data"]] <- value
  pass_list[["domains"]] <- c("j", "cty")

  value_aggregate <- aggregateIMPACT(df = pass_list, ...)
  value_aggregate <- levelSum(df = value_aggregate, dim_name = "long_name")
  value_mag <- as.magpie(value_aggregate)

  quantity_aggregate <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "QSX0"),
                                      ...)
  quantity_aggregate <-
    levelSum(df = quantity_aggregate, dim_name = "long_name")
  quantity_mag <- collapseNames(as.magpie(quantity_aggregate))

  common_elements <-
    intersect(getNames(collapseNames(value_mag)), getNames(quantity_mag))

  price_aggregate <- value_mag / quantity_mag[, , common_elements]

  df <- as.data.frame(price_aggregate)[-1]

  colnames(df) <- c(getSets(as.magpie(value_aggregate)), "value")
  df <- name_cleaner(df = df, fix_only_na = TRUE)

  return(df)
}
