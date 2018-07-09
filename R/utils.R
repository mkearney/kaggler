
##----------------------------------------------------------------------------##
##                                  WRANGLING                                 ##
##----------------------------------------------------------------------------##

#' Convert kaggle output to tibble
#'
#' Convert kaggle response objects into informative tibbles
#'
#' @param x Output from kaggle function
#' @return Print out of summary info and a tibble of the data.
#' @export
kgl_as_tbl <- function(x) {
  if (inherits(x, "response")) {
    x <- tryCatch(as_json(x), error = function(e) as_parsed(x))
  }
  if (length(x) == 1 && is.list(x) && is.data.frame(x[[1]])) {
    x <- x[[1]]
  }
  x <- tibble::as_tibble(x[!is_recursive(x)], validate = FALSE)
  parse_datetimes(x)
}

parse_datetimes <- function(x) {
  x[grep("deadline|date", names(x), ignore.case = TRUE)] <- lapply(
    x[grep("deadline|date", names(x), ignore.case = TRUE)], parse_datetime
  )
  x
}

parse_datetime <- function(x) {
  as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%SZ", tz = "UTC"), tz = "UTC")
}


as_parsed <- function(x) httr::content(x)

as_json <- function(r) jsonlite::fromJSON(httr::content(r,
  as = "text", encoding = "UTF-8"))

readlines <- function(x, ...) {
  con <- file(x)
  x <- readLines(con, warn = FALSE, encoding = "UTF-8", ...)
  close(con)
  x
}

##----------------------------------------------------------------------------##
##                              OBJECT VALIDATION                             ##
##----------------------------------------------------------------------------##

is_recursive <- function(x) vapply(x, is.recursive, logical(1))


##----------------------------------------------------------------------------##
##                                RENVIRON FUNS                               ##
##----------------------------------------------------------------------------##


set_renv <- function(...) {
  dots <- list(...)
  stopifnot(are_named(dots))
  vars <- names(dots)
  x <- paste0(names(dots), "=", dots)
  x <- paste(x, collapse = "\n")
  for (var in vars) {
    check_renv(var)
  }
  append_lines(x, file = .Renviron())
  readRenviron(.Renviron())
}

check_renv <- function(var = NULL) {
  if (!file.exists(.Renviron())) return(invisible())
  if (is_incomplete(.Renviron())) {
    append_lines("", file = .Renviron())
  }
  if (!is.null(var)) {
    clean_renv(var)
  }
  invisible()
}

.Renviron <- function() {
  if (file.exists(".Renviron")) {
    ".Renviron"
  } else {
    file.path(home(), ".Renviron")
  }
}

is_incomplete <- function(x) {
  con <- file(x)
  x <- tryCatch(readLines(con, encoding = "UTF-8"), warning = function(w) return(TRUE))
  close(con)
  ifelse(isTRUE(x), TRUE, FALSE)
}

has_name_ <- function(x, name) isTRUE(name %in% names(x))

define_args <- function(args, ...) {
  dots <- list(...)
  nms <- names(dots)
  for (i in nms) {
    if (!has_name_(args, i)) {
      args[[i]] <- dots[[i]]
    }
  }
  args
}

home <- function() {
  if (!identical(Sys.getenv("HOME"), "")) {
    file.path(Sys.getenv("HOME"))
  } else {
    file.path(normalizePath("~"))
  }
}

append_lines <- function(x, ...) {
  args <- define_args(
    c(x, list(...)),
    append = TRUE,
    fill = TRUE
  )
  do.call("cat", args)
}

clean_renv <- function(var) {
  x <- readlines(.Renviron())
  x <- grep(sprintf("^%s=", var), x, invert = TRUE, value = TRUE)
  writeLines(x, .Renviron())
}

are_named <- function(x) is_named(x) && !"" %in% names(x)

is_named <- function(x) !is.null(names(x))
