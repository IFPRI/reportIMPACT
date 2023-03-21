#' getReport
#'
#' @param gdx final GDX from an IMPACT run
#' @param prep_flag Who processed data
#' @param export if RDS file should be written
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
                      export=TRUE){
  message("Start getReport(gdx)...")
  t <- Sys.time()

  out_list <- list()
  cols <- colnames(reportPopulation(gdx))
  out_list[["Population"]] <- reportPopulation(gdx)
  out_list[["Animal Numbers"]] <- reportAnimals(gdx)

  out <- rbindlist(out_list,use.names=TRUE, fill=TRUE)
  out <- out[,cols,with = FALSE]
  out$prep_flag <- prep_flag

  if (export){
    export_dir <- paste0(dirname(gdx), "/", gsub(pattern = ".gdx", replacement = "", x = basename(gdx)),".rds")
    saveRDS(object = out, file = export_dir)
  } else return(out)
  message("Finished post processing in ",round(difftime(Sys.time(), t, units='mins'),1), " minutes")
}
