#' getReport
#'
#' @param gdx final GDX from an IMPACT run
#' @param prep_flag Who processed data
#' @param export if RDS file should be written
#' @param base_year Base year on which relative index can be calculated
#'
#' @return Full data output
#'
#' @import DOORMAT
#' @importFrom data.table rbindlist
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- getReport(gdx)}
#' @export

getReport <- function(gdx,
                      prep_flag = "Default",
                      export=TRUE,
                      base_year = 2005){
  message("Start getReport(gdx)...")
  t <- Sys.time()

  out_list <- list()
  cols <- suppressMessages(colnames(reportPopulation(gdx)))

  # Custom function for additional calcs ----
  additional_calculation <- function(base_list,
                                     name,
                                     base_year) {
    stopifnot(is.list(out_list))
    stopifnot(is.character(name))
    stopifnot(is.numeric(base_year))

    dummy <- list()

    dummy[[paste0(name," (relative)")]] <- calcRelative(df = base_list[[name]],
                                                           base_year = base_year)
    dummy[[paste0(name," (index)")]]    <- calcRelative(df = base_list[[name]],
                                                           base_year = base_year,
                                                           type = "index")
    return(append(base_list,dummy))
  }

  # Population ----
  name = "Population"
  out_list[[name]]            <- reportPopulation(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Population ----
  name = "Household Population"
  out_list[[name]]            <- reportHouseholdPopulation(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Animal Numbers ----
  name = "Animal Numbers"
  out_list[[name]]            <- reportAnimals(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Export Quantity ----
  name = "Export quantity"
  out_list[[name]]            <- reportExport(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Net Trade ----
  name = "Net Trade"
  out_list[[name]]            <- reportNetTrade(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Food Availability ----
  name = "Food Availability"
  out_list[[name]]            <- reportFoodAvailability(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Crop Area ----
  name = "Crop Area"
  out_list[[name]]            <- reportCropArea(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # GDP ----
  name = "GDP"
  out_list[[name]]            <- reportGDP(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Income ----
  name = "Household Income"
  out_list[[name]]            <- reportHouseholdIncome(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Hunger Risk ----
  name = "Hunger Risk"
  out_list[[name]]            <- reportHungerRisk(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Hunger Risk ----
  name = "Biofuel feedstock"
  out_list[[name]]            <- reportBiofuelFeedstock(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Demand ----
  name = "Demand"
  out_list[[name]]            <- reportDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Demand ----
  name = "Household demand"
  out_list[[name]]            <- reportHouseholdDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)


  # Combine Results
  out <- rbindlist(out_list,use.names=TRUE, fill=TRUE)
  out$unit2[is.na(out$unit2)] = "Default"

  # Add flag to idnetify
  out$prep_flag <- prep_flag

  if (export){
    export_dir <- paste0(dirname(gdx), "/", gsub(pattern = ".gdx", replacement = "", x = basename(gdx)),".rds")
    saveRDS(object = out, file = export_dir)
    message("Results exported to ", export_dir,"\n")
  } else return(out)
  message("\nFinished post processing in ",round(difftime(Sys.time(), t, units='mins'),1), " minutes")
}
