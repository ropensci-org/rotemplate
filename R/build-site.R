#' Build rOpenSci docs sites
#'
#' Wrapper for [pkgdown::build_site] that we use to build the websites
#' for `https://docs.ropensci.org`. Sets a theme and logo, checks if
#' mathjax is required, and injects a logo into the readme if needed.
#'
#' Note the default behavior is to render the docs using the installed
#' package, i.e. not reinstall the package on the fly (which does not
#' always work well). In production, we manually install the package
#' before running `build_ro_site`.
#'
#' @export
#' @param path path to package source directory
#' @param preview preview the website (servr will be used)
#' @param destination path where to save the docs website
#' @param install passed to [pkgdown::build_site]. Default is to _not_ reinstall the package.
#' @param ... passed to [pkgdown::build_site]
build_ropensci_docs <- function(path = ".", destination = NULL, install = FALSE, preview = interactive(), ...) {
  path <- normalizePath(path, mustWork = TRUE)
  desc <- as.data.frame(read.dcf(file.path(path, 'DESCRIPTION')))
  pkgname <- desc$Package
  title <- sprintf("rOpenSci: %s", pkgname)
  deploy_url <- sprintf("https://docs.ropensci.org/%s", pkgname)
  #NB: pkgdown uses utils::modifyList() to merge _pkgdown.yml values with overrides.
  #This will recursively merge lists, and delete values that are 'NULL' in overrides.
  override <- list(
    template = list(
      package = "rotemplate",
      params = list(mathjax = need_mathjax(path), bootswatch = NULL),
      path = NULL
    ),
    home = list(strip_header = NULL),
    navbar = list(type = NULL),
    development = list(mode = 'release'),
    title = title,
    url = deploy_url,
    destination = destination
  )
  find_and_fix_readme(path, pkgname)
  Sys.setenv(NOT_CRAN="true")
  Sys.unsetenv('CI') #TODO: https://github.com/r-lib/pkgdown/issues/1958
  pkg <- pkgdown::as_pkgdown(path, override = override)
  pkgdown::build_site(pkg = pkg, ..., install = install, preview = FALSE, devel = FALSE)
  if (preview) {
    servr::httw(pkg$dst_path)
  }
}

need_mathjax <- function(path){
  pkgdown_yml <- pkgdown_config_path(path = path)
  isTRUE(try({
    if(!is.null(pkgdown_yml)){
      pkgdown_config <- yaml::read_yaml(pkgdown_yml)
      if(isTRUE(pkgdown_config$mathjax) || isTRUE(pkgdown_config$template$params$mathjax)){
        message("Site needs mathjax library")
        return(TRUE)
      }
    }
    message("Site does not need mathjax")
  }))
}

find_and_fix_readme <- function(path, pkg){
  # From pkgdown build_home_index()
  home_files <- file.path(path, c("index.Rmd", "README.Rmd", "index.md", "README.md"))
  home_files <- Filter(file.exists, home_files)
  if(!length(home_files))
    stop("Package does not contain an index.(r)md or README.(r)md file")
  lapply(home_files, modify_ropensci_readme, pkg = pkg)
}


modify_ropensci_readme <- function(file, pkg){
  readme <- readLines(file)
  h1 <- find_h1_line(readme)
  has_logo <- isTRUE(grepl("(<img|!\\[)", h1$input))
  if(!has_logo){
    message("Inserting rOpenSci logo in readme")
    banner <- ropensci_main_banner(pkg)
    if(is.na(h1$pos)){
      readme <- c(banner, readme)
    } else {
      readme[h1$pos] <- banner
      if(isTRUE(grepl("^[= ]+$", readme[h1$pos + 1])))
        readme[h1$pos + 1] = ""
    }
  }
  ugly_footer <- find_old_footer_banner(readme)
  readme[ugly_footer] = ""
  writeLines(readme, file)
}

ropensci_main_banner <- function(title){
  sprintf('# rOpenSci: The *%s* package <img src="hexlogo.png" align="right" width="120" />', title)
}

find_h1_line <- function(txt){
  doc <- xml2::read_xml(commonmark::markdown_xml(txt, sourcepos = TRUE))
  doc <- xml2::xml_ns_strip(doc)
  node <- xml2::xml_find_first(doc, "//heading[@level='1'][text]")
  sourcepos <- xml2::xml_attr(node, 'sourcepos')
  pos <- as.integer(strsplit(sourcepos, ':')[[1]][1])
  title <- xml2::xml_text(xml2::xml_find_all(node, 'text'))
  input <- xml2::xml_text(node)
  list(pos = pos, title = title, input = input)
}

find_old_footer_banner <- function(txt){
  which(grepl('\\[.*\\]\\(.*/(ropensci|github)_footer.png\\)', txt))
}

# from https://github.com/r-lib/usethis/blob/865e9294f2f3f21b43c545f6b896360a56df28fd/R/pkgdown.R#L142
pkgdown_config_path <- function(path) {
  path_first_existing(
    file.path(
      path,
      c(
        "_pkgdown.yml",
        "_pkgdown.yaml",
        "pkgdown/_pkgdown.yml",
        "pkgdown/_pkgdown.yaml",
        "inst/_pkgdown.yml",
        "inst/_pkgdown.yaml"
      )
    )
  )
}

# adapted from https://github.com/r-lib/usethis/blob/7c8e0049a1e40e6dcabbde069bb29576215a11b6/R/utils.R#L75
path_first_existing <- function(paths) {
  for (i in seq_along(paths)) {
    path <- paths[[i]]
    if (file.exists(path)) {
      return(path)
    }
  }

  NULL
}
