#' Return population data of country
#'
#' @param country_name The name of a country
#'
#' @returns A data frame of population and year
#'
#' @importFrom stats na.omit
#' @importFrom xml2 as_list read_xml xml_child xml_children xml_integer
#'
#' @export
population <- function(country_name) {
  country_code <-
    countrycode::countrycode(country_name, origin = "country.name", destination = "wb")

  url <-
    paste0("http://api.worldbank.org/v2/country/",
           country_code,
           "/indicator/SP.POP.TOTL")

  x <- read_xml(url)

  Year <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_integer(year_xml, "wb:date"), numeric(1))

  Population <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_integer(year_xml, "wb:value"), numeric(1))

  na.omit(data.frame(Year, Population))
}
