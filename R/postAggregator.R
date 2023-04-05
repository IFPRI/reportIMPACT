#' Post Aggregator
#'
#' @param df Dataframe which is received from clean_description
#' @param gdx A gdx file to check for the standard columns
#' @param col The "indicator" column
#' @param type which kind of post aggregation is needed
#'
#' @return Dataframe with correct aggregation to subscales (upper level aggregation)
#' @export
#'
#' @examples
#' \dontrun{x <- postAggregator(df)}
#' @export

postAggregator <- function(df, gdx, col="indicator", type="crop_area"){

  basic_names <- colnames(reportPopulation(gdx))

  core_indicator <- unlist(strsplit(unique(df$indicator), split = "\\|")[[1]])[1]

  pending_agg <- setdiff(colnames(df),basic_names)

  out_list <- list()
  out_list[["df"]] <- df

  aggregation_func <- function(df,agg_col,col){

    value <- NULL

    skip_col <- c("value",col)

    cols <- colnames(df)[!(colnames(df) %in% c(agg_col,skip_col))]

    temp <- df %>%
      group_by(across(all_of(cols))) %>%
      summarise(value = sum(value,na.rm = TRUE))

    temp[,agg_col] <- NA
    temp[,col] <- core_indicator
    temp <- name_cleaner(temp)
    temp <- temp[,colnames(df)]

    return(temp)

  }

  if(length(pending_agg)>0){

    # Crop Area
    if(identical(c("fctr","groups","long_name"), pending_agg)){

      # Fctr Aggregate
      agg_col <- c("fctr")
      out_list[["fctr"]] <- aggregation_func(df = df,
                                             agg_col = agg_col,
                                             col = col)

      # long_name aggregate
      agg_col <- c("fctr","long_name")
      out_list[["long_name"]] <- aggregation_func(df = df,
                                                  agg_col = agg_col,
                                                  col = col)
    }

  }

  out <- rbindlist(out_list)

  out$indicator <- gsub(pattern = "\\|NA",replacement = "",x = out$indicator)

  return(out)

}
