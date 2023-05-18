#' ExportShareProduction
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO ExportShareProduction
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- ExportShareProduction(gdx)}
#' @export

ExportShareProduction <- function(gdx, ...) {
  pwx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "PWX0")$data))

  qex0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QEX0")$data))
  qsupx0 <- collapseNames(as.magpie(readGDX(gdx = gdx, name = "QSUPX0")$data))

  QEXVal <- pwx0 * qex0
  QSXVal <- pwx0 * qsupx0[, , getItems(pwx0)$c]


  QEXVal[is.na(QEXVal)] <- 0
  QSXVal[is.na(QSXVal)] <- 0

  mag_to_df <- function(mag_obj, domains, ...) {
    dummy <- as.data.frame(mag_obj)[-1]
    colnames(dummy) <- c(getSets(mag_obj), "value")
    colnames(dummy) <- gsub(pattern = "region",
                            replacement = "cty",
                            x = colnames(dummy))
    pass_list <- list()
    pass_list[["data"]] <- dummy
    pass_list[["domains"]] <- domains

    dummy_aggregate <- aggregateIMPACT(df = pass_list, ...)
    dummy_aggregate <- levelSum(df = dummy_aggregate, dim_name = "long_name")
    return(dummy_aggregate)
  }

  qex_mag <- as.magpie(mag_to_df(mag_obj = QEXVal, domains = c("c", "cty")))
  qsx_mag <- as.magpie(mag_to_df(mag_obj = QSXVal, domains = c("c", "cty")))

  QESH <- qex_mag / qsx_mag

  df <- as.data.frame(QESH)[-1]
  colnames(df) <- c(getSets(QESH), "value")

  df$description <- "Export Share of production (Share)"

  return(df)
}
