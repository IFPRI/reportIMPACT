#' Producer Prices
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO producerPrices
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie add_dimension getSets getNames dimSums mbind getRegions
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- producerPrices(gdx)}
#' @export

producerPrices <- function(gdx){
  prices <- as.magpie(readGDX(gdx = gdx,name = "PPX0")[["data"]],spatial="cty",temporal="yrs")
  production <- as.magpie(readGDX(gdx = gdx,name = "QSX0")[["data"]],spatial="cty",temporal="yrs")

  # At this stage, the unit is 000 2005 USD but later will be divided by 000 mt so okay to
  # keep unit as 2005 USD per mt here
  value <- prices[getRegions(production),,] * collapseNames(production)
  value[is.na(value)] <- 0

  value <- as.data.frame(value)[-1]

  colnames(value) <- c(getSets(prices),"value")

  pass_list <- list()
  pass_list[["data"]] <- value
  pass_list[["domains"]] <- c("j","cty")

  value_aggregate <- aggregateIMPACT(df = pass_list)
  value_aggregate <- levelSum(df = value_aggregate, dim_name = "long_name")

  production_aggregate <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QSX0"))
  production_aggregate <- levelSum(df = production_aggregate, dim_name = "long_name")

  price_aggregate <- as.magpie(value_aggregate)/collapseNames(as.magpie(production_aggregate))

  df <- as.data.frame(price_aggregate)[-1]

  colnames(df) <- c(getSets(as.magpie(value_aggregate)),"value")
  df <- name_cleaner(df = df,fix_only_na = TRUE)

  return(df)
}
