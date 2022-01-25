test_that("bootswatch is overriden", {
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
  yaml$template<- list(bootstrap = 5, bootswatch = "readable")
  yaml::write_yaml(yaml, "_pkgdown.yml")
  expect_output({
    docs <- build_ropensci_docs(
      .verbose = FALSE,
      destination = "docs",
      install = FALSE,
      examples = FALSE)
  })
})

test_that("bootswatch (old syntax) is overriden", {
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
  yaml$template<- list(bootstrap = 5, params = list(bootswatch = "readable"))
  yaml::write_yaml(yaml, "_pkgdown.yml")
  expect_output({
    docs <- build_ropensci_docs(
      .verbose = FALSE,
      destination = "docs",
      install = FALSE,
      examples = FALSE)
  })
})
