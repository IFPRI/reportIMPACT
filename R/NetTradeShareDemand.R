#' NetTradeShareDemand
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO NetTradeShareDemand
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- NetTradeShareDemand(gdx)}
#' @export

NetTradeShareDemand <- function(gdx, ...) {
  pwx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "PWX0")$data))

  qdx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "qdx0")$data))
  qsupx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QSUPX0")$data))

  QDXVal <- pwx0 * qdx0[,,getItems(pwx0)$c]
  QSXVal <- pwx0 * qsupx0[,,getItems(pwx0)$c]

  QNXVal <- QSXVal - QDXVal

  QNXVal[is.na(QNXVal)] <- 0
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

  qnx_mag <- as.magpie(mag_to_df(mag_obj = QNXVal,domains = c("c","cty")))
  qdx_mag <- as.magpie(mag_to_df(mag_obj = QDXVal,domains = c("c","cty")))

  QNSH <- qnx_mag / qdx_mag

  df <- as.data.frame(QNSH)[-1]
  colnames(df) <- c(getSets(QNSH), "value")

  df$description <- "Net trade Share of Demand (Share)"

  return(df)
}
