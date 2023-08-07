#' getReport
#'
#' @param gdx final GDX from an IMPACT run
#' @param additional_indicators If non-core indicators should be read.
#' @param prep_flag Who processed data.
#' Defaults to user name from the computer where this script is run.
#' @param export if RDS file should be written. Defaults to TRUE
#' @param base_year Base year on which relative index can be calculated.
#' Default 2005.
#' @param sp_mapping Which mapping to use. See mapping file in DOORMAT package.
#' @param relative_calc If relative calculations should be done
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
                      additional_indicators = FALSE,
                      prep_flag = NULL,
                      export = TRUE,
                      base_year = NULL,
                      sp_mapping = "Standard-IMPACT_dis1",
                      relative_calc = FALSE) {

  # Create a prep flag - user name usually
  if (is.null(prep_flag)) {
    cat("\nGrabbing user name\n")
    prep_flag <- as.vector(Sys.info()["effective_user"])
  }

  # Pull base year data if not provided
  if (is.null(base_year)) {
    cat("\nGrabbing first year of simulation\n")
    base_year <- as.numeric(as.character(readGDX(gdx = gdx,
                                                 name = "YRT1")[["data"]]$yrs))
  }

  # Message output
  message("Start getReport(gdx)...")
  t <- Sys.time()

  # Pull the basic indicator column names - to standardize output
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

  # Find R scripts in the package
  all_files <- list.files(path = "./R")

  # Find R scripts which start with "report"
  all_reports <-
    gsub(pattern = "\\.R",
         replacement = "",
         x = all_files[startsWith(x = all_files, prefix = "report")])

  # Declare "core" functions
  core_func <- c("reportPopulation",
                 "reportGDP",
                 "reportPerCapGDP",
                 "reportAnimals",
                 "reportExport",
                 "reportImport",
                 "reportNetTrade",
                 "reportCropArea",
                 "reportBiofuelFeedstock",
                 "reportLSFDemand",
                 "reportDemand",
                 "reportIntermediateDemand",
                 "reportOtherDemand",
                 "reportSupply",
                 "reportProduction",
                 "reportYields",
                 "reportConsumerPrices",
                 "reportProducerPrices",
                 "reportWeightedWorldPrices",
                 "reportSingleWorldPrices")

  # Decalre a NULL object to add on top of core functions
  extra_calls <- NULL

  # If additional indicators requested - find which indicators are not added
  if (additional_indicators) {
    extra_calls <- setdiff(all_reports, core_func)
  }

  # Declare which reporting calls to run
  func_name <- c(core_func, extra_calls)

  # Provide additional arguments <- TBD to make it function specific
  arg_call <- "(gdx, sp_mapping = sp_mapping)"

  # Declare final function calls
  func_name_args <- paste0(func_name, arg_call)


  # Create relative Indicators
  out <- do.call(rbind, lapply(func_name_args, function(func) {
    display <- gsub(pattern = arg_call, replacement = "", x = func)
    message(paste("Calling", display, "....."))
    temp <- eval(parse(text = func))[, cols]
    temp$unit2 <- temp$unit
    if (relative_calc) {
      relative_indicators <- additional_calculation(base_list = temp,
                                                    base_year = base_year)
      rbind(temp, relative_indicators)
    }
  }))

  # Unit 2 as "real" unit if it doesnt exist
  out$unit2[is.na(out$unit2)] <- out$unit[is.na(out$unit2)]

  # Add flag to identify
  out$prep_flag <- prep_flag

  # Factorize regions
  out$region <- as.factor(out$region)

  # Move "GLO" to last level
  if ("GLO" %in% levels(out$region)) {
    out$region <- forcats::fct_relevel(out$region, "GLO", after = Inf)
    }

  # Write to disk if needed (by default it is TRUE)
  if (export) {
    export_dir <- paste0(dirname(gdx), "/", gsub(pattern = ".gdx",
                                                 replacement = "",
                                                 x = basename(gdx)), ".rds")
    saveRDS(object = out, file = export_dir)
    message("\nResults exported to ", export_dir)
  } else {
    return(out)
  }

  # Throw end message
  message("\nFinished post processing in ",
          round(difftime(Sys.time(), t, units = "sec"), 1), " seconds")
}
