test_that("adding mathjax works", {
  withr::local_options(usethis.quiet = TRUE)
  temp_dir <- withr::local_tempdir()
  proj <- usethis::create_package(
    file.path(temp_dir, "testPackage"),
    rstudio = FALSE,
    open = FALSE
  )
  usethis::local_project(proj)
  usethis::use_readme_md()
  usethis::use_pkgdown()
  yaml <- yaml::read_yaml("_pkgdown.yml")
  yaml$mathjax <- TRUE
  yaml::write_yaml(yaml, "_pkgdown.yml")
  expect_output({
    suppressMessages(
      docs <- build_ropensci_docs(
        destination = "docs",
        install = FALSE,
        examples = FALSE)
    )
  })
  homepage <- xml2::read_html(file.path(docs, "index.html"), encoding = "UTF-8")
  script <- xml2::xml_find_first(homepage, ".//script[contains(@src,'MathJax')]")
  # If not present the class is xml_missing
  testthat::expect_s3_class(script, "xml_node")
})

test_that("NOT adding mathjax works", {
  withr::local_options(usethis.quiet = TRUE)
  temp_dir <- withr::local_tempdir()
  proj <- usethis::create_package(
    file.path(temp_dir, "testPackage"),
    rstudio = FALSE,
    open = FALSE
  )
  usethis::local_project(proj)
  usethis::use_readme_md()
  usethis::use_pkgdown()
  expect_output({
    suppressMessages(
      docs <- build_ropensci_docs(
        destination = "docs",
        install = FALSE,
        examples = FALSE)
    )
  })
  homepage <- xml2::read_html(file.path(docs, "index.html"), encoding = "UTF-8")
  script <- xml2::xml_find_first(homepage, ".//script[contains(@src,'MathJax')]")
  testthat::expect_s3_class(script, "xml_missing")
})
