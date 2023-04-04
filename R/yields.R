#' Yields
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO Yields
#'
#' @import gamstransfer DOORMAT
#' @importFrom magclass as.magpie setNames getSets as.data.frame collapseNames where
#' @importFrom dplyr group_by summarise %>%
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- Yields(gdx)}
#' @export

yields <- function(gdx){

  setNames <- getSets <- NULL

  message(".....Calculating FPU level area")
  area_fpu <- readGDX(gdx = gdx,name = "AREAX0")[["data"]]

  message(".....Calculating FPU level yields")
  yld_fpu  <- readGDX(gdx = gdx,name = "YLDX0")[["data"]]

  area_fpu_mag <- collapseNames(as.magpie(area_fpu,spatial="fpu"))
  yld_fpu_mag  <- collapseNames(as.magpie(yld_fpu,spatial="fpu"))

  message(".....Calculating FPU level production")
  production_fpu <- area_fpu_mag * yld_fpu_mag

  if(length((where(is.na(area_fpu_mag) & !(is.na(production_fpu)))$true)$years)) {
    stop("  Likely incorrect calculation in FPU level production calculation.
         Production exists with no area information in some FPU(s).
         Aborting.")
  }

  production <- as.data.frame(production_fpu)[,-1]

  colnames(production) <- c(getSets(production_fpu),"value")

  fpu_map <- readGDX(gdx = gdx,name = "fpu2cty")[["data"]]

  message(".....Calculating country level production")
  production_cty <- merge(production, fpu_map[,c("fpu","cty")], by = "fpu")

  if (nrow(production_cty) != nrow(production)) warning(
    "Merge was likley not successful.\nProceed with EXTREME caution")

  production_cty_agg <- production_cty %>%
    group_by(across(all_of(c("yrs","j","fctr","cty")))) %>%
    summarise(value = sum(.data$value,na.rm = TRUE))

  production_cty_agg$description <- "Solution crop area (000 mt)"
  production_cty_agg$model <- "IMPACT"

  production_cty_agg <- production_cty_agg[,colnames(readGDX(gdx = gdx,name = "AREACTYX0")[["data"]])]

  prod_list <- list()
  prod_list[["data"]] <- production_cty_agg
  prod_list[["domains"]] <- readGDX(gdx = gdx,name = "AREACTYX0")[["domains"]]

  prod_final <- aggregateIMPACT(prod_list)

  message(".....Retrieving country level crop area")
  crop_area_agg <- cropArea(gdx = gdx)

  mag_prod_agg      <- collapseNames(as.magpie(prod_final,spatial="region"))
  mag_crop_area_agg <- collapseNames(as.magpie(crop_area_agg,spatial="region"))

  message(".....Calculating country level aggregated yield")
  yld_agg <- mag_prod_agg / mag_crop_area_agg

  yld_df <- as.data.frame(yld_agg)[,-1]

  colnames(yld_df) <- c(getSets(mag_prod_agg),"value")

  yld_df$description <- "Aggregated Yield (mt per ha)"
  yld_df$model <- "IMPACT"

  df <- yld_df[,colnames(crop_area_agg)]

  return(df)
}
