
#' CompetitionsDataListFiles
#'
#' List competition data files
#'
#' @param id string, Competition name. Required: TRUE.
#' @export
kgl_competitions_data_list <- function(id) {
  kgl_api_get(glue::glue("competitions/data/list/{id}"))
}

#' CompetitionsDataDownloadFile
#'
#' Download competition data file
#'
#' @param id string, Competition name. Required: TRUE.
#' @param fileName string, Competition name. Required: TRUE.
#' @export
kgl_competitions_data_download <- function(id, fileName) {
  kgl_api_get(glue::glue(
    "competitions/data/download/{id}/{fileName}"))
}
