

#' DatasetsList
#'
#' List datasets
#'
#' @param page integer, Page number. Defaults to 1. Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug)
#' @param search string, Search terms. Defaults to . Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug)
#' @param ownerSlug string, Dataset owner. Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug). If ownerSlug and datasetSlug
#'   are not NULL, this function looks for the matching dataset.
#' @param datasetSlug string, Dataset name. Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug). If ownerSlug and datasetSlug
#'   are not NULL, this function looks for the matching dataset.
#' @export
kgl_datasets_list <- function(page = 1, search = "",
                              ownerSlug = NULL, datasetSlug = NULL) {
  if (!is.null(ownerSlug) && !is.null(datasetSlug)) {
    kgl_api_get(glue::glue("datasets/list/{ownerSlug}/{datasetSlug}"))
  } else {
    kgl_api_get("datasets/list", page = page, search = search)
  }
}

#' DatasetsView
#'
#' Show details about a dataset
#'
#' @param ownerSlug string, Dataset owner. Required: TRUE.
#' @param datasetSlug string, Dataset name. Required: TRUE.
#' @export
kgl_datasets_view <- function(ownerSlug, datasetSlug) {
  kgl_api_get(glue::glue("datasets/view/{ownerSlug}/{datasetSlug}"))
}

#' DatasetsDownloadFile
#'
#' Download dataset file
#'
#' @param ownerSlug string, Dataset owner. Required: TRUE.
#' @param datasetSlug string, Dataset name. Required: TRUE.
#' @param fileName string, File name. Required: TRUE.
#' @param datasetVersionNumber string, Dataset version number. Required: FALSE.
#' @export
kgl_datasets_download <- function(ownerSlug, datasetSlug, fileName,
                                  datasetVersionNumber = NULL) {
  kgl_api_get(glue::glue(
    "datasets/download/{ownerSlug}/{datasetSlug}/{fileName}"),
    datasetVersionNumber = datasetVersionNumber)
}

#' DatasetsUploadFile
#'
#' Get URL and token to start uploading a data file
#'
#' @param fileName string, Dataset file name. Required: TRUE.
#' @param contentLength integer, Content length of file in bytes. Required: TRUE.
#' @param lastModifiedDateUtc integer, Last modified date of file in milliseconds
#'   since epoch in UTC. Required: TRUE.
#' @export
kgl_datasets_upload_file <- function(fileName, contentLength,
                                     lastModifiedDateUtc) {
  contentLength <- file.size(fileName)
  lastModifiedDateUtc <- format(file.info(fileName)$mtime,
    format = "%Y-%m-%d %H-%M-%S", tz = "UTC")
  kgl_api_post(glue::glue(
    "datasets/upload/file/{contentLength}/{lastModifiedDateUtc}"),
    fileName = fileName)
}

#' DatasetsCreateVersion
#'
#' Create a new dataset version
#'
#' @param ownerSlug string, Dataset owner. Required: TRUE.
#' @param datasetSlug string, Dataset name. Required: TRUE.
#' @param datasetNewVersionRequest Information for creating a new dataset version.
#'   Required: TRUE.
#' @export
kgl_datasets_create_version <- function(ownerSlug, datasetSlug,
                                        datasetNewVersionRequest) {
  kgl_api_post(glue::glue(
    "datasets/create/version/{ownerSlug}/{datasetSlug}"),
    datasetNewVersionRequest = datasetNewVersionRequest)
}

#' DatasetsCreateNew
#'
#' Create a new dataset
#'
#' @param datasetNewRequest Information for creating a new dataset. Required: TRUE.
#' @export
kgl_datasets_create_new <- function(datasetNewRequest) {
  kgl_api_post("datasets/create/new", datasetNewRequest = datasetNewRequest)
}
