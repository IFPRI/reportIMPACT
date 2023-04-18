#' getReport
#'
#' @param gdx final GDX from an IMPACT run
#' @param prep_flag Who processed data. Defaults to user name from the computer where this script is run.
#' @param export if RDS file should be written. Defaults to TRUE
#' @param base_year Base year on which relative index can be calculated. Default 2005.
#'
#' @return Full data output
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom data.table rbindlist
#' @importFrom forcats fct_relevel
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- getReport(gdx)}
#' @export

getReport <- function(gdx,
                      prep_flag = NULL,
                      export=TRUE,
                      base_year = 2005){

  if(is.null(prep_flag)){
    cat("\nGrabbing user name\n")
    prep_flag <- as.vector(Sys.info()["effective_user"])
  }

  message("Start getReport(gdx)...")
  t <- Sys.time()

  out_list <- list()
  cols <- suppressMessages(colnames(reportPopulation(gdx)))

  # Custom function for additional calcs ----
  additional_calculation <- function(base_list,
                                     name,
                                     base_year) {
    stopifnot(is.list(base_list))
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

  # Dummy text
  reading <- "Reading "
  trail <- " ........"

  # Population ----
  name = "Population"
  message(reading,name,trail)
  out_list[[name]]            <- reportPopulation(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Population ----
  name = "Household Population"
  message(reading,name,trail)
  out_list[[name]]            <- reportHouseholdPopulation(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # GDP ----
  name = "GDP"
  message(reading,name,trail)
  out_list[[name]]            <- reportGDP(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Income ----
  name = "Household Income"
  message(reading,name,trail)
  out_list[[name]]            <- reportHouseholdIncome(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # GDP Per Capita ----
  name = "Per capita GDP"
  message(reading,name,trail)
  out_list[[name]]            <- reportPerCapGDP(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Animal Numbers ----
  name = "Animal Numbers"
  message(reading,name,trail)
  out_list[[name]]            <- reportAnimals(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Export Quantity ----
  name = "Export quantity"
  message(reading,name,trail)
  out_list[[name]]            <- reportExport(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Import Quantity ----
  name = "Import quantity"
  message(reading,name,trail)
  out_list[[name]]            <- reportImport(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Net Trade ----
  name = "Net Trade"
  message(reading,name,trail)
  out_list[[name]]            <- reportNetTrade(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Food Availability ----
  name = "Food Availability"
  message(reading,name,trail)
  out_list[[name]]            <- reportFoodAvailability(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Crop Area ----
  name = "Crop Area"
  message(reading,name,trail)
  out_list[[name]]            <- reportCropArea(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Hunger Risk ----
  name = "Hunger Risk"
  message(reading,name,trail)
  out_list[[name]]            <- reportHungerRisk(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Malnourished ----
  name = "Malnourished children"
  message(reading,name,trail)
  out_list[[name]]            <- reportMalnourished(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Biofuel Feedstock ----
  name = "Biofuel feedstock"
  message(reading,name,trail)
  out_list[[name]]            <- reportBiofuelFeedstock(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Livestock Feed Demand ----
  name = "Livestock feed demand"
  message(reading,name,trail)
  out_list[[name]]            <- reportLSFDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Demand ----
  name = "Demand"
  message(reading,name,trail)
  out_list[[name]]            <- reportDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Household Demand ----
  name = "Household demand"
  message(reading,name,trail)
  out_list[[name]]            <- reportHouseholdDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Intermediate Demand ----
  name = "Intermediate demand"
  message(reading,name,trail)
  out_list[[name]]            <- reportIntermediateDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Other Demand ----
  name = "Other demand"
  message(reading,name,trail)
  out_list[[name]]            <- reportOtherDemand(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Supply ----
  name = "Supply"
  message(reading,name,trail)
  out_list[[name]]            <- reportSupply(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Production ----
  name = "Production"
  message(reading,name,trail)
  out_list[[name]]            <- reportProduction(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Yields ----
  name = "Yields"
  message(reading,name,trail)
  out_list[[name]]            <- reportYields(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Consumer prices ----
  name = "Consumer Prices"
  message(reading,name,trail)
  out_list[[name]]            <- reportConsumerPrices(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Producer prices ----
  name = "Producer Prices"
  message(reading,name,trail)
  out_list[[name]]            <- reportProducerPrices(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Aggregated World Prices ----
  name = "Aggregated world prices"
  message(reading,name,trail)
  out_list[[name]]            <- reportWeightedWorldPrices(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)

  # Single World Prices ----
  name = "Single world prices"
  message(reading,name,trail)
  out_list[[name]]            <- reportSingleWorldPrices(gdx)
  out_list <- additional_calculation(base_list = out_list,name = name,base_year = base_year)


  # Combine Results
  out <- rbindlist(out_list,use.names=TRUE, fill=TRUE)
  out$unit2[is.na(out$unit2)] = "Default"

  # Add flag to idnetify
  out$prep_flag <- prep_flag

  out$region <- as.factor(out$region)

  if("GLO" %in% levels(out$region)) out$region <- forcats::fct_relevel(out$region, "GLO", after = Inf)

    if (export){
    export_dir <- paste0(dirname(gdx), "/", gsub(pattern = ".gdx", replacement = "", x = basename(gdx)),".rds")
    saveRDS(object = out, file = export_dir)
    message("\nResults exported to ", export_dir)
  } else return(out)
  message("\nFinished post processing in ",round(difftime(Sys.time(), t, units='sec'),1), " seconds")
}
