#' KCal per Capita per Commodity
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return Per capita KCal availability
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie getItems as.data.frame getYears
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- PerCapKCalCommodity(gdx)}
#' @export

PerCapKCalCommodity <- function(gdx, ...) {
  getYears <- NULL

  PerCapKCal_Com <- collapseNames(
    as.magpie(readGDX(gdx = gdx, name = "PerCapKCal_Com")$data))

  population <-
    collapseNames(as.magpie(readGDX(gdx = gdx, name = "POPX0")$data))

  valid_regs <- getItems(PerCapKCal_Com, dim = 1)
  valid_yrs  <- getItems(PerCapKCal_Com, dim = 2)

  PerCapKCal_Com_total <- PerCapKCal_Com * population[valid_regs, valid_yrs, ]

  df <- as.data.frame(PerCapKCal_Com_total)[, -1]
  colnames(df) <- c(getSets(PerCapKCal_Com_total), "value")

  df_list <- list()
  df_list$data <- df
  df_list$domains <- c("c", "cty")

  df_aggregated <- as.magpie(aggregateIMPACT(df = df_list, ...),
                             spatial = "region")
  pop_agg <- as.magpie(aggregateIMPACT(readGDX(gdx = gdx, name = "POPX0"), ...),
                       spatial = "region")
  out <- collapseNames(df_aggregated / pop_agg[, getYears(df_aggregated), ])

  df <- as.data.frame(out)[, -1]
  colnames(df) <- c(getSets(out), "value")

  df <- df[, colnames(aggregateIMPACT(df = df_list))]
  df$description <- "Commodity wise per capita Kcal (Kcal/cap)"

  return(df)
}
