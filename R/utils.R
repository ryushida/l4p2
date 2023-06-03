#' Extract integer from xml data for a year
#'
#' @param year_xml xml data for a year
#' @param node name of the child node
#'
#' @returns An integer
extract_integer <- function(year_xml, node) {
  xml_integer(xml_child(year_xml, node))
}

#' Extract double from xml data for a year
#'
#' @param year_xml xml data for a year
#' @param node name of the child node
#'
#' @importFrom xml2 xml_child xml_double
#'
#' @returns An integer
extract_double <- function(year_xml, node) {
  xml_double(xml_child(year_xml, node))
}
