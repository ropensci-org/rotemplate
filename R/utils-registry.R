find_review_number <- function(pkgname) {

  if (!curl::has_internet()) {
    message("No internet connection, can't look up the package registry for software review info.")
    return(NULL)
  }

  registry <- read_registry()

  pkg_entry <- registry[purrr::map_chr(registry, "pkgname") == pkgname]

  if (length(pkg_entry) == 0) {
    return(NULL)
  }

  pkg_entry[[1]][["iss_no"]]
}

.read_registry <- function() {
  registry <- try(
    jsonlite::read_json(
      "https://badges.ropensci.org/json/onboarded.json"
    ),
    silent = TRUE
  )

  if (inherits(registry, "try-error")) {
    return(NULL)
  }

  registry
}

#' @importFrom memoise memoise
read_registry <- memoise::memoise(.read_registry)
