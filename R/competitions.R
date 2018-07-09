#' CompetitionsList
#'
#' List competitions
#'
#' @param page integer, Page number. Defaults to 1. Required: FALSE.
#' @param search string, Search terms. Defaults to . Required: FALSE.
#' @export
kgl_competitions_list <- function(page = 1, search = "") {
  kgl_api_get("competitions/list", page = page, search = search)
}
