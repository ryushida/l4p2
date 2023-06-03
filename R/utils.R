#' Extract integer from xml data for a year
#'
#' @param year_xml xml data for a year
#' @param node name of the child node
#'
#' @returns An integer
#'
#' @importFrom xml2 xml_child xml_integer
extract_integer <- function(year_xml, node) {
  xml_integer(xml_child(year_xml, node))
}

#' Extract double from xml data for a year
#'
#' @param year_xml xml data for a year
#' @param node name of the child node
#'
#' @returns A double
#'
#' @importFrom xml2 xml_child xml_double
extract_double <- function(year_xml, node) {
  xml_double(xml_child(year_xml, node))
}
