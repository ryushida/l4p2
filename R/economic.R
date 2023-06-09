#' Return GDP data of country
#'
#' @param country_code The code of a country
#'
#' @returns A data frame of gdp and year
#'
#' @importFrom stats na.omit
#' @importFrom xml2 read_xml xml_children
#'
#' @export
gdp_by_code <- function(country_code) {
  url <-
    paste0("http://api.worldbank.org/v2/country/",
           country_code,
           "/indicator/NY.GDP.MKTP.CD")

  x <- read_xml(url)

  Year <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_integer(year_xml, "wb:date"), numeric(1))

  GDP <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_double(year_xml, "wb:value"), numeric(1))

  na.omit(data.frame(Year, GDP))
}

#' Return GDP data of country by name
#'
#' @param country_name The name of a country
#'
#' @returns A data frame of gdp and year
#'
#' @export
gdp <- function(country_name) {
  country_code <-
    countrycode::countrycode(country_name, origin = "country.name", destination = "wb")

  gdp_by_code(country_code)
}

#' Return GDP per capita data of country
#'
#' @param country_name The name of a country
#'
#' @returns A data frame of gdp per capita and year
#'
#' @importFrom stats na.omit
#' @importFrom xml2 read_xml xml_children
#'
#' @export
gdp_per_capita <- function(country_name) {
  country_code <-
    countrycode::countrycode(country_name, origin = "country.name", destination = "wb")

  url <-
    paste0("http://api.worldbank.org/v2/country/",
           country_code,
           "/indicator/NY.GDP.PCAP.CD")

  x <- read_xml(url)

  Year <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_integer(year_xml, "wb:date"), numeric(1))

  GDP_per_capita <-
    vapply(rev(xml_children(x)), function(year_xml)
      extract_double(year_xml, "wb:value"), numeric(1))

  na.omit(data.frame(Year, GDP_per_capita))
}
