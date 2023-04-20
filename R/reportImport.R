#' reportImport
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO export
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- reportImport(gdx)}
#' @export

reportImport <- function(gdx) {
  df <- import(gdx = gdx)
  df$indicator <- "Import"

  df <- clean_description(df)

  return(df)
}
