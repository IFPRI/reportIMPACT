#' Level based summing
#'
#' @param df A dataframe which comes out of aggregateIMPACT function call
#' @param dim_name The column to be summed over. Usually "long_name"
#' @param spatial Which column contains spatial info. Defaults to "region"
#' @param temporal Which column contains temporal info. Defaults to "yrs"
#' @param na.rm If NAs should be ignored during sum. Defaults to TRUE
#' @param bind If new aggregation should be binded to the original dataframe
#' passed on to "df" argument
#'
#' @importFrom magclass as.magpie getSets mbind
#'
#' @return Aggregated dataframe
#'
#' @examples
#' \dontrun{x <- levelSum(df)}
#'
#' @export

levelSum <- function(df, dim_name = NULL, spatial = "region", temporal = "yrs",
                     na.rm = TRUE, bind = TRUE) {

  df_mag <- as.magpie(df, spatial = spatial, temporal = temporal)

  dim_to_sum <- as.numeric(gsub(pattern = "d",
                                replacement = "",
                                x = names(getSets(df_mag)[
                                  getSets(df_mag) == dim_name])))

  new_name <- paste0(dim_name, "_SUM")

  temp <- add_dimension(x = dimSums(x = df_mag,
                                    dim = dim_name,
                                    na.rm = na.rm),
                        add = dim_name,
                        nm = new_name,
                        dim = dim_to_sum)


  out <- temp

  if (bind) out <- mbind(df_mag, temp)

  out <- as.data.frame(out)[-1]

  colnames(out) <- c(getSets(df_mag), "value")

  out[, dim_name] <- gsub(pattern = new_name, replacement = NA,
                          x = out[, dim_name])

  return(out)

}
