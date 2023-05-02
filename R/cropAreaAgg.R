#' cropAreaAgg
#'
#' @param gdx final GDX from an IMPACT run
#' @param ... Arguments to aggregateIMPACT call. See ?aggregateIMPACT
#' @return GLO cropAreaAgg
#'
#' @importFrom DOORMAT readGDX aggregateIMPACT
#' @importFrom magclass as.magpie add_dimension
#' getSets getNames dimSums mbind add_columns
#' @importFrom readxl read_xlsx
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- cropAreaAgg(gdx)}
#' @export

cropAreaAgg <- function(gdx, ...) {
  df <- aggregateIMPACT(df = readGDX(gdx = gdx, name = "AREACTYX0"), ...)

  fpath <- system.file("extdata", file = "mapping_items.xlsx",
                       package = "DOORMAT")

  group_disagg_mapping <- read_xlsx(path = fpath,
                                    sheet = "Aggregation Crops",
                                    range = "B8:D150",
                                    .name_repair = "unique_quiet")

  colnames(group_disagg_mapping) <- tolower(gsub(pattern = " |-",
                                                 replacement = "_",
                                                 x = colnames(
                                                   group_disagg_mapping)))
  group_disagg_mapping <- unique(group_disagg_mapping)

  df <- merge(df, group_disagg_mapping)

  df_mag <- as.magpie(df)

  df_mag <- add_columns(x = df_mag, dim = "fctr", addnm = "IRRF", fill = NA)
  df_mag[, , "IRRF"] <- dimSums(df_mag, dim = "fctr", na.rm = TRUE)

  df <- as.data.frame(df_mag)[-1]

  colnames(df) <- c(getSets(df_mag), "value")

  df <- df[, !(colnames(df) %in% "variable")]

  return(df)
}
