#' Extract integer from xml data for a year
#'
#' @param year_xml xml data for a year
#' @param node name of the child node
#'
#' @returns An integer
extract_integer <- function(year_xml, node) {
  xml_integer(xml_child(year_xml, node))
}
