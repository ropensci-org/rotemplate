find_review_number <- function(pkgname) {

  if (!curl::has_internet()) {
    message("No internet connection, can't look up the package registry for software review info.")
    return(NULL)
  }

  registry <- read_registry()
  pkg_entry <- registry$packages[purrr::map_chr(registry$packages, "name") == pkgname]

  if (!nzchar(pkg_entry[[1]][["onboarding"]])) {
    return(NULL)
  }

  sub(".*issues/", "", pkg_entry[[1]][["onboarding"]])
}

.read_registry <- function() {
  jsonlite::read_json(
    "https://raw.githubusercontent.com/ropensci/roregistry/gh-pages/registry.json"
  )
}

#' @importFrom memoise memoise
read_registry <- memoise::memoise(.read_registry)
