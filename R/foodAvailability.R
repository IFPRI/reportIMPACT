#' FoodAvailability
#'
#' @param gdx final GDX from an IMPACT run
#'
#' @return GLO FoodAvailability
#'
#' @import gamstransfer DOORMAT
#' @importFrom magclass as.magpie setNames getSets as.data.frame
#' @author Abhijeet Mishra
#' @examples
#' \dontrun{x <- foodAvailability(gdx)}
#' @export

foodAvailability <- function(gdx){

  setNames <- getSets <- NULL

  food_demand <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "QFX0"))
  population <- aggregateIMPACT(df = readGDX(gdx = gdx,name = "POPX0"))

  dfx <- as.magpie(food_demand)/setNames(as.magpie(population),NULL)

  df <- as.data.frame(dfx)[,-1]

  colnames(df) <- c(getSets(dfx),"value")

  df <- df[,colnames(food_demand)]

  df$description <- gsub(pattern = "000 mt",replacement = "kg per capita",x = df$description)
  df$description <- gsub(pattern = "Soultion household demand aggregated to cty",replacement = "Food Availability",x = df$description)

  return(df)
}
