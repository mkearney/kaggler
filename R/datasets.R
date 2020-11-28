

#' DatasetsList
#'
#' List datasets
#'
#' @param page integer, Page number. Defaults to 1. Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug)
#' @param search string, Search terms. Defaults to . Retrieve datasets via
#'   page, search, or (ownerSlug and datasetSlug)
#' @param owner_dataset Alternative to page/search.  The owner and dataset
#'   slug as it appears in the URL, i.e.,
#'   \code{"mathan/fifa-2018-match-statistics"}.
#' @export
kgl_datasets_list <- function(page = 1, search = "",
                              owner_dataset = NULL) {
  if (!is.null(owner_dataset)) {
    owner_dataset <- strsplit(owner_dataset, "/")[[1]]
    ownerSlug <- owner_dataset[1]
    datasetSlug <- owner_dataset[2]
    kgl_api_get(glue::glue("datasets/list/{ownerSlug}/{datasetSlug}"))
  } else {
    kgl_api_get("datasets/list", page = page, search = search)
  }
}

#' DatasetsView
#'
#' Show details about a dataset
#'
#' @param owner_dataset The owner and data set slug as it appears in the URL,
#'   i.e., \code{"mathan/fifa-2018-match-statistics"}.
#' @export
kgl_datasets_view <- function(owner_dataset) {
  owner_dataset <- strsplit(owner_dataset, "/")[[1]]
  ownerSlug <- owner_dataset[1]
  datasetSlug <- owner_dataset[2]
  kgl_api_get(glue::glue("datasets/view/{ownerSlug}/{datasetSlug}"))
}

#' DatasetsDownloadFile
#'
#' Download dataset file
#'
#' @param owner_dataset The owner and data set slug as it appears in the URL,
#'   i.e., \code{"mathan/fifa-2018-match-statistics"}.
#' @param fileName string, File name. Required: TRUE.
#' @param datasetVersionNumber string, Dataset version number. Required: FALSE.
#' @export
kgl_datasets_download <- function(owner_dataset, fileName,
                                  datasetVersionNumber = NULL) {
  owner_dataset <- strsplit(owner_dataset, "/")[[1]]
  ownerSlug <- owner_dataset[1]
  datasetSlug <- owner_dataset[2]
  kgl_api_get(glue::glue(
    "datasets/download/{ownerSlug}/{datasetSlug}/{fileName}"),
    datasetVersionNumber = datasetVersionNumber)
}

#' DatasetsDownloadFileAll
#'
#' Download dataset files
#'
#' @param owner_dataset The owner and data set slug as it appears in the URL,
#'   i.e., \code{"mathan/fifa-2018-match-statistics"}.
#' @param datasetVersionNumber string, Dataset version number. Required: FALSE.
#' @export
kgl_datasets_download_all <- function(owner_dataset) {
  owner_dataset <- strsplit(owner_dataset, "/")[[1]]
  ownerSlug <- owner_dataset[1]
  datasetSlug <- owner_dataset[2]
  kgl_api_get(glue::glue("datasets/download/{ownerSlug}/{datasetSlug}"))
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
#' @param owner_dataset The owner and data set slug as it appears in the URL,
#'   i.e., \code{"mathan/fifa-2018-match-statistics"}.
#' @param datasetNewVersionRequest Information for creating a new dataset version.
#'   Required: TRUE.
#' @export
kgl_datasets_create_version <- function(owner_dataset,
                                        datasetNewVersionRequest) {
  owner_dataset <- strsplit(owner_dataset, "/")[[1]]
  ownerSlug <- owner_dataset[1]
  datasetSlug <- owner_dataset[2]
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
