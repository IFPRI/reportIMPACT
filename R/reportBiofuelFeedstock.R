#' reportBiofuelFeedstock
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO BiofuelFeedstock
#'
#' @import gamstransfer DOORMAT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportBiofuelFeedstock(gdx)}
#' @export

reportBiofuelFeedstock <- function(gdx){
  df <- biofuelFeedstock(gdx = gdx)
  df$indicator <- "Biofuel feedstock demand"

  df <- clean_description(df)

  return(df)
}