#' reportCropArea
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO CropArea
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportCropArea(gdx)}
#' @export

reportCropArea <- function(gdx){
  df <- cropArea(gdx = gdx)
  df$indicator <- "Crop area"

  df <- clean_description(df)

  return(df)
}
