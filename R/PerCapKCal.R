#' KCal per Capita
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return Per capita KCal availability
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie getItems as.data.frame setYears getYears
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- PerCapKCal(gdx)}
#' @export

PerCapKCal <- function(gdx, ...) {
  setYears <- getYears <- NULL

  tot_cal_cap <- collapseNames(
    as.magpie(readGDX(gdx = gdx, name = "TotalCalorie")$data))

  tot_cal_cap_other <- collapseNames(
    as.magpie(readGDX(gdx = gdx, name = "TotalOtherCalories")$data))

  cal_cap <- dimSums(tot_cal_cap, dim = "c", na.rm = TRUE) +
    setYears(tot_cal_cap_other[getItems(tot_cal_cap, dim = 1), , ], NULL)

  population <-
    collapseNames(as.magpie(readGDX(gdx = gdx, name = "POPX0")$data))

  cal_pop <-
    collapseNames(
      cal_cap * population[getItems(cal_cap, 1), getItems(cal_cap, 2), ])

  df <- as.data.frame(cal_pop)[, -1]

  colnames(df) <- c(getSets(cal_pop), "value")

  df_list <- list()
  df_list$data <- df
  df_list$domains <- "cty"

  df_aggregated <- as.magpie(aggregateIMPACT(df = df_list, ...))
  pop_agg <- as.magpie(population(gdx))

  out <- df_aggregated / pop_agg[, getYears(df_aggregated), ]

  df <- as.data.frame(out)[, -1]
  colnames(df) <- c(getSets(out), "value")

  df <- df[, colnames(population(gdx))]
  df$description <- "Per capita Kcal (Kcal/cap)"

  return(df)
}
