#' percapGDP
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO percapGDP
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- percapGDP(gdx)}
#' @export

percapGDP <- function(gdx) {
  gdp <- GDP(gdx)
  pop <- population(gdx)

  gdp_pc <- setNames(
    collapseNames(as.magpie(gdp, spatial = "region"))
    /
      collapseNames(as.magpie(pop, spatial = "region")),
    "Per capita GDP (000 USD)")

  gdp_pc <- add_dimension(x = gdp_pc,
                          dim = 3.2,
                          add = "model",
                          nm = unique(gdp$model))

  df <- as.data.frame(gdp_pc)[-1]

  colnames(df) <- c(getSets(as.magpie(gdp, spatial = "region")), "value")

  return(df)
}
