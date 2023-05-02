#' reportAnimals
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO Animals
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportAnimals(gdx)}
#' @export

reportAnimals <- function(gdx, ...) {
  df <- animals(gdx = gdx, ...)
  df$indicator <- "Animals"

  df <- clean_description(df)

  # lvsys is same across all set elements, pick any one

  df <- df[df$lvsys %in% unique(df$lvsys)[1], ]

  return(df)
}
