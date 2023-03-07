#' File locator
#'
#' @param source Path to IMPACT model run
#'
#' @return directory 
#' @export
#'
#' @examples
#' x <- file_locator()
#' 
#' @author Abhijeet Mishra

file_locator <- function(source){
  if(!dir.exists(source)) stop("Invalid source folder. Provide path to model folder.")
}