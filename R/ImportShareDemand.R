#' ImportShareDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO ImportShareDemand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- ImportShareDemand(gdx)}
#' @export

ImportShareDemand <- function(gdx, ...) {
  pwx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "PWX0")$data))

  qmx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QMX0")$data))
  qdx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QDX0")$data))

  QMXVal <- pwx0 * qmx0
  QDXVal <- pwx0 * qdx0[,,getItems(pwx0)$c]


  QMXVal[is.na(QMXVal)] <- 0
  QDXVal[is.na(QDXVal)] <- 0

  mag_to_df <- function(mag_obj, domains, ...){
    dummy <- as.data.frame(mag_obj)[-1]
    colnames(dummy) <- c(getSets(mag_obj), "value")
    colnames(dummy) <-
      gsub(pattern = "region", replacement = "cty",x = colnames(dummy))
    pass_list <- list()
    pass_list[["data"]] <- dummy
    pass_list[["domains"]] <- domains

    dummy_aggregate <- aggregateIMPACT(df = pass_list, ...)
    dummy_aggregate <- levelSum(df = dummy_aggregate, dim_name = "long_name")
    return(dummy_aggregate)
  }

  qmx_mag <- as.magpie(mag_to_df(mag_obj = QMXVal,domains = c("c","cty")))
  qdx_mag <- as.magpie(mag_to_df(mag_obj = QDXVal,domains = c("c","cty")))

  QMSH <- qmx_mag / qdx_mag

  df <- as.data.frame(QMSH)[-1]
  colnames(df) <- c(getSets(QMSH), "value")

  df$description <- "Import Share of Demand (Share)"

  if (any(df$value > 1.00000001)
      ) warning("Some import shares of demand > 1 detected")

  return(df)
}
