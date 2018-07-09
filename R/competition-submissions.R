#' CompetitionsSubmissionsUrl
#'
#' Generate competition submission URL
#'
#' @param fileName string, Competition submission file name. Required: FALSE.
#' @param contentLength integer, Content length of file in bytes. Required: TRUE.
#' @param lastModifiedDateUtc integer, Last modified date of file in milliseconds
#'   since epoch in UTC. Required: TRUE.
#' @export
kgl_competitions_submissions_url <- function(fileName = NULL,
                                             contentLength,
                                             lastModifiedDateUtc) {
  contentLength <- file.size(fileName)
  lastModifiedDateUtc <- format(file.info(fileName)$mtime,
    format = "%Y-%m-%d %H-%M-%S", tz = "UTC")
  kgl_api_post(glue::glue(
    "competitions/submissions/url/{contentLength}/{lastModifiedDateUtc}"),
    fileName = fileName)
}

#' CompetitionsSubmissionsUpload
#'
#' Upload competition submission file
#'
#' @param file file, Competition submission file. Required: TRUE.
#' @param guid string, Location where submission should be uploaded. Required:
#'   TRUE.
#' @param contentLength integer, Content length of file in bytes. Required: TRUE.
#' @param lastModifiedDateUtc integer, Last modified date of file in milliseconds
#'   since epoch in UTC. Required: TRUE.
#' @export
kgl_competitions_submissions_upload <- function(file, guid,
                                                contentLength,
                                                lastModifiedDateUtc) {
  contentLength <- file.size(file)
  lastModifiedDateUtc <- format(file.info(file)$mtime,
    format = "%Y-%m-%d %H-%M-%S", tz = "UTC")
  kgl_api_post(glue::glue(
    "competitions/submissions/upload/{guid}/{contentLength}/",
    "{lastModifiedDateUtc}"),
    body = httr::upload_file(file))
}

#' CompetitionsSubmissionsSubmit
#'
#' Submit to competition
#'
#' @param blobFileTokens string, Token identifying location of uploaded submission
#'   file. Required: TRUE.
#' @param submissionDescription string, Description of competition submission.
#'   Required: TRUE.
#' @param id string, Competition name. Required: TRUE.
#' @export
kgl_competitions_submissions_submit <- function(blobFileTokens,
                                                submissionDescription,
                                                id) {
  kgl_api_post(glue::glue("competitions/submissions/submit/{id}"),
    blobFileTokens = blobFileTokens,
    submissionDescription = submissionDescription)
}
