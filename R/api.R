
## globals

#' @export
.kaggle_host_url <- "https://www.kaggle.com"

#' @export
.kaggle_base_url <- "https://www.kaggle.com/api/v1"

## URL builder
kgl_api_call <- function(path, ...) {
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
kgl_api_get <- function(path, ..., auth = kgl_auth()) {
  ## build and make request
  r <- httr::GET(kgl_api_call(path, ...), auth)

  ## check status
  httr::warn_for_status(r)

  ## print message
  if (r$status_code != 200) {
    m <- httr::content(r)
    if ("message" %in% names(m)) cat(m$message, fill = TRUE)
  } else {
    b <- r
    r <- tryCatch(r, error = function(e) return(NULL))
    if (is.null(r) %||% nrow(r) == 0) {
      r <- interpret_response(r, type=guess_type(path))
    }
  }

  ## return data/response
  r
}

## Get last characters
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

## Guess type from path                  
guess_type <- function(path) {
    if (substrRight(path, 4) == ".csv")  {
        return("csv")
    }
  return(NULL)
}

interpret_response <- function(response, type=NULL) {
    if (is.null(type)) {
        http_T <- httr::http_type(response)
    } else {
        http_T <- type
    }
    if (grepl("json",http_T)) {
        return(as_json(response))
    }
    if (grepl("ms\\-excel",http_T)) {
        print("ciao")
        return(httr::content(response, "text"))
    }
    if (grepl("csv",http_T))  {
        return(read.csv(text=httr::content(response, "text")))
    }
    return(response)
}

`%||%` <- function(a, b) {
  if (length(a) > 0) a else b
}

## for POST requests
kgl_api_post <- function(path, ..., body = NULL) {
  ## build and make request
  r <- httr::POST(kgl_api_call(path, ...), body = body)

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
