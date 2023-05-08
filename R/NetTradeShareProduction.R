#' NetTradeShareProduction
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO NetTradeShareProduction
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- NetTradeShareProduction(gdx)}
#' @export

NetTradeShareProduction <- function(gdx, ...) {
  pwx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "PWX0")$data))

  qdx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "qdx0")$data))
  qsupx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QSUPX0")$data))

  QDXVal <- pwx0 * qdx0[,,getItems(pwx0)$c]
  QSXVal <- pwx0 * qsupx0[,,getItems(pwx0)$c]

  QNXVal <- QSXVal - QDXVal

  QNXVal[is.na(QNXVal)] <- 0
  QSXVal[is.na(QSXVal)] <- 0

  mag_to_df <- function(mag_obj, domains, ...){
    dummy <- as.data.frame(mag_obj)[-1]
    colnames(dummy) <- c(getSets(mag_obj), "value")
    colnames(dummy) <- gsub(pattern = "region", replacement = "cty",x = colnames(dummy))
    pass_list <- list()
    pass_list[["data"]] <- dummy
    pass_list[["domains"]] <- domains

    dummy_aggregate <- aggregateIMPACT(df = pass_list, ...)
    dummy_aggregate <- levelSum(df = dummy_aggregate, dim_name = "long_name")
    return(dummy_aggregate)
  }

  qnx_mag <- as.magpie(mag_to_df(mag_obj = QNXVal,domains = c("c","cty")))
  qsx_mag <- as.magpie(mag_to_df(mag_obj = QSXVal,domains = c("c","cty")))

  QNSH1 <- qnx_mag / qsx_mag

  df <- as.data.frame(QNSH1)[-1]
  colnames(df) <- c(getSets(QNSH1), "value")

  df$description <- "Net trade share of production (Share)"

  return(df)
}
