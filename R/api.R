?globalVariables

## globals

#' @export
.kaggle_host_url <- "https://www.kaggle.com"

#' @export
.kaggle_base_url <- "https://www.kaggle.com/api/v1"

## URL builder
kaggle_api_call <- function(path, ...) {
  ## clean path and build url
  url <- paste0(.kaggle_base_url, "/", gsub("^/+|/+$", "", path))

  ## capture dots
  dots <- list(...)

  ## if query/params provided as list, unlist
  if (length(dots) == 1L && is.list(dots[[1]])) {
    dots <- dots[[1]]
  }

  ## args must be named!
  if (length(dots) > 0 && (is.null(names(dots)) || any("" %in% names(dots)))) {
    stop("Unnamed arguments were sent to the internal API call builder. ",
      "Query string arguments must be named!")
  }

  ## build query string
  if (length(dots) > 0L) {
    dots <- paste0(names(dots), "=", dots)
    dots <- paste(dots, collapse = "&")
    url <- paste0(url, "?", dots)
  }

  ## return url
  url
}

## for GET requests
kaggle_api_get <- function(path, ..., auth = kaggle_auth()) {
  ## build and make request
  r <- httr::GET(kaggle_api_call(path, ...), auth)

  ## check status
  httr::warn_for_status(r)

  ## print message
  if (r$status_code != 200) {
    m <- httr::content(r)
    if ("message" %in% names(m)) cat(m$message, fill = TRUE)
  } else {
    b <- r
    r <- kaggle_as_tbl(r)
    if (nrow(r) == 0) {
      r <- as_json(b)
    }
  }

  ## return data/response
  r
}

## for POST requests
kaggle_api_post <- function(path, ..., body = NULL) {
  ## build and make request
  r <- httr::POST(kaggle_api_call(path, ...), body = body)

  ## check status
  httr::warn_for_status(r)

  ## print message
  if (r[[grep("status", names(r), value = TRUE)]] != 200) {
    m <- httr::content(r)
    if ("message" %in% names(m)) cat(m$message, fill = TRUE)
  }

  ## return data/response
  invisible(r)
}
