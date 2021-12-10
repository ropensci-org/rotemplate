#' Build website using rotemplate
#'
#' @param pkg Path to package folder
#' @param preview Wether to preview the website (servr will be used)
#' @param ...
#'
#' @return Nothing
#' @export
#'
build_ro_site <- function(pkg = ".", preview = TRUE, ...) {
  pkg <- pkgdown::as_pkgdown(
    pkg,
    override = list(template = list(package = "rotemplate"))
  )
  pkg$meta$navbar <- NULL

  pkgdown::build_site(pkg = pkg, ..., preview = FALSE)

  if (is.null(preview)) preview <- TRUE

  if (preview) {
    servr::httw(pkg$dst_path)
  }
}
