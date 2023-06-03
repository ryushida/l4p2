#' Return random list of countries
#'
#' @param n An integer
#'
#' @returns A vector
#'
#' @importFrom stats na.omit
#'
#' @export
random_countries <- function(n) {
  sample(na.omit(countrycode::codelist$wb), n)
}

#' Return data for n random countries
#'
#' @param n An integer
#'
#' @returns A data frame with data for n countries
#'
#' @import dplyr
#'
#' @export
random_countries_data <- function(n) {
  country_codes <- random_countries(n)
  population_df_list <-
    lapply(country_codes, function(country)
      population_by_code(country) %>% mutate(Country = country, .before = 1))

  gdp_df_list <- lapply(country_codes, function(country)
    gdp_by_code(country) %>% mutate(Country = country, .before = 1))

  populations <- bind_rows(population_df_list)
  gdps <- bind_rows(gdp_df_list)

  merge(
    populations,
    gdps,
    by.x = c("Country", "Year"),
    by.y = c("Country", "Year")
  )
}

#' Returns clusters for n random countries
#'
#' @param n An integer of the number of countries
#' @param centers An integer of the number of clusters
#'
#' @returns A plot
#'
#' @import dplyr
#' @import ggplot2
#'
#' @export
clusters <- function(n = 10, centers = 3) {
  latest <- random_countries_data(n) %>%
    filter(.data$Year == max(.data$Year))

  latest_kmeans <- latest %>%
    select(.data$Year, .data$GDP) %>%
    stats::kmeans(centers)

  latest$Cluster <- as.factor(latest_kmeans$cluster)

  latest %>% ggplot(aes(
    x = .data$Population,
    y = .data$GDP,
    color = .data$Cluster
  )) +
    geom_point() +
    labs(title = "K-Means Clustering of Countries") +
    theme_minimal()
}
