#' getReport
#'
#' @param gdx final GDX from an IMPACT run
#' @param prep_flag Who processed data.
#' Defaults to user name from the computer where this script is run.
#' @param export if RDS file should be written. Defaults to TRUE
#' @param base_year Base year on which relative index can be calculated.
#' Default 2005.
#' @param sp_mapping Which mapping to use. See mapping file in DOORMAT package.
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
                      export = TRUE,
                      base_year = NULL,
                      sp_mapping = "Standard-IMPACT_dis1") {

  if (is.null(prep_flag)) {
    cat("\nGrabbing user name\n")
    prep_flag <- as.vector(Sys.info()["effective_user"])
  }

  if (is.null(base_year)) {
    cat("\nGrabbing first year of simulation\n")
    base_year <- as.numeric(as.character(readGDX(gdx = gdx,
                                                 name = "YRT1")[["data"]]$yrs))
  }

  message("Start getReport(gdx)...")
  t <- Sys.time()

  cols <- suppressMessages(colnames(reportPopulation(gdx)))

  # Custom function for additional calcs ----
  additional_calculation <- function(base_list,
                                     base_year) {
    stopifnot(is.list(base_list))
    stopifnot(is.numeric(base_year))

    dummy <- list()

    dummy[["relative"]] <-
      calcRelative(df = base_list, base_year = base_year)

    dummy[["index"]]    <-
      calcRelative(df = base_list, base_year = base_year,
                   type = "index")
    return(rbindlist(dummy))
    }

  func_name <- c("reportPopulation(gdx, sp_mapping = sp_mapping)",
                 "reportHouseholdPopulation(gdx, sp_mapping = sp_mapping)",
                 "reportGDP(gdx, sp_mapping = sp_mapping)",
                 "reportHouseholdIncome(gdx, sp_mapping = sp_mapping)",
                 "reportPerCapGDP(gdx, sp_mapping = sp_mapping)",
                 "reportAnimals(gdx, sp_mapping = sp_mapping)",
                 "reportExport(gdx, sp_mapping = sp_mapping)",
                 "reportImport(gdx, sp_mapping = sp_mapping)",
                 "reportNetTrade(gdx, sp_mapping = sp_mapping)",
                 "reportFoodAvailability(gdx, sp_mapping = sp_mapping)",
                 "reportCropArea(gdx, sp_mapping = sp_mapping)",
                 "reportBiofuelFeedstock(gdx, sp_mapping = sp_mapping)",
                 "reportLSFDemand(gdx, sp_mapping = sp_mapping)",
                 "reportDemand(gdx, sp_mapping = sp_mapping)",
                 "reportHouseholdDemand(gdx, sp_mapping = sp_mapping)",
                 "reportIntermediateDemand(gdx, sp_mapping = sp_mapping)",
                 "reportOtherDemand(gdx, sp_mapping = sp_mapping)",
                 "reportSupply(gdx, sp_mapping = sp_mapping)",
                 "reportProduction(gdx, sp_mapping = sp_mapping)",
                 "reportYields(gdx, sp_mapping = sp_mapping)",
                 "reportConsumerPrices(gdx, sp_mapping = sp_mapping)",
                 "reportProducerPrices(gdx, sp_mapping = sp_mapping)",
                 "reportWeightedWorldPrices(gdx, sp_mapping = sp_mapping)",
                 "reportSingleWorldPrices(gdx, sp_mapping = sp_mapping)",
                 "reportHungerRisk(gdx, sp_mapping = sp_mapping)",
                 "reportMalnourished(gdx, sp_mapping = sp_mapping)"
                 )

  out <- NULL
  for (func in func_name){
    display <- gsub(pattern = "report|\\(gdx\\)", replacement = "", x = func)
    display <- gsub("([a-z])([A-Z])", "\\1 \\2", display)
    message(paste("Reading", display, "....."))
    temp <- eval(parse(text = func))[, cols]
    temp$unit2 <- temp$unit
    relative_indicators <- additional_calculation(base_list = temp,
                                                  base_year = base_year)
    temp <- rbind(temp, relative_indicators)
    out <- rbind(out, temp)
  }

  out$unit2[is.na(out$unit2)] <- out$unit[is.na(out$unit2)]

  # Add flag to identify
  out$prep_flag <- prep_flag

  out$region <- as.factor(out$region)

  if ("GLO" %in% levels(out$region)) {
    out$region <- forcats::fct_relevel(out$region, "GLO", after = Inf)
    }

  if (export) {
    export_dir <- paste0(dirname(gdx), "/", gsub(pattern = ".gdx",
                                                 replacement = "",
                                                 x = basename(gdx)), ".rds")
    saveRDS(object = out, file = export_dir)
    message("\nResults exported to ", export_dir)
  } else {
    return(out)
    }
  message("\nFinished post processing in ",
          round(difftime(Sys.time(), t, units = "sec"), 1), " seconds")
}
