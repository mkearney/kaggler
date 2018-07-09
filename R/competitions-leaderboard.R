
#' CompetitionDownloadLeaderboard
#'
#' Download competition leaderboard
#'
#' @param id string, Competition name. Required: TRUE.
#' @export
kgl_competitions_leaderboard_download <- function(id) {
  kgl_api_get(glue::glue("competitions/{id}/leaderboard/download"))
}

#' CompetitionViewLeaderboard
#'
#' VIew competition leaderboard
#'
#' @param id string, Competition name. Required: TRUE.
#' @export
kgl_competitions_leaderboard_view <- function(id) {
  kgl_api_get(glue::glue("competitions/{id}/leaderboard/view"))
}
