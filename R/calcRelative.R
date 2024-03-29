#' Calculate relative change for IMPACT indicators
#'
#' @param df Full IMAPCT result for an indicator
#' @param base_year base year on which the relative indicator is calculated
#' @param cols columns which are used for relative index calculation
#' @param type If relative index is calculate in same unit ('same_unit') or as
#' an index on base year ('index')
#'
#' @importFrom dplyr group_by_at mutate %>% case_when
#' @return Recalculate dataframe with relative calculation
#' @export
#'
#' @examples
#' \dontrun{x <- calcRelative(df=reportPopulation(gdx))}
#' @export

calcRelative <- function(df,
                         base_year = 2005,
                         cols = c("description", "model",
                                  "indicator", "region", "unit"),
                         type = "same_unit") {

  if (!(type %in% c("same_unit", "index")
       )) {
    stop("Incorrect calculation type. Use 'same_unit' or 'index'.")
    }

  value <- yrs <- unit <- NULL

  if (type == "same_unit") {
    df <- df %>%
      group_by_at(cols) %>%
      mutate(value = value - value[yrs == base_year]) %>%
      mutate(unit2 = paste0(unit,
                            " (wrt ", base_year, ")"))
  }

  if (type == "index") {
    df <- df %>%
      group_by_at(cols) %>%
      mutate(value = value / value[yrs == base_year]) %>%
      mutate(unit2 = paste0("Index ",
                            " (wrt ", base_year, ")"))
  }

  return(df)

}
