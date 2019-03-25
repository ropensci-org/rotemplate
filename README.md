
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rotemplate <a href='https://ropenscilabs.github.io/rotemplate'><img src='man/figures/logo.png' align="right" height="134.5" /></a>

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build
Status](https://travis-ci.org/ropensci/rotemplate.svg?branch=master)](https://travis-ci.org/ropensci/rotemplate)
<!-- badges: end -->

rotemplate provides a custom pkgdown template for rOpenSci packages.
Please don’t use it for your own package if it’s not an rOpenSci package
(i.e. only use it for packages listed on
<https://ropensci.org/packages/>).

Inspired by [tidytemplate](https://github.com/tidyverse/tidytemplate/)
and [lockedatapkg](https://github.com/lockedatapublished/lockedatapkg).

## How to use

### If your website has no `pkgdown` website yet

Run

``` r
usethis::use_pkgdown()
```

And to ensure your website will be automatically deployed from Travis,
which we recommend,

``` r
usethis::use_pkgdown_travis()
```

### In all cases

#### Tweak the `pkgdown` config

In your `pkgdown` config file make sure to add the following lines

``` yaml
template:
  package: rotemplate
```

#### Tweak the Travis config

To `.travis.yml` also add a command installing the package template,
i.e. something like
`remotes::install_cran("pkgdown");remotes::install_github("ropenscilabs/rotemplate")`.

Locally, if you want to build and preview the website, you’ll also need
to run `remotes::install_github("ropenscilabs/rotemplate")`.

#### Make sure the website has a favicon

If your package has no logo of its own, use the rOpenSci hex by running
the code below, but do not necessarily put it in the README as mentioned
by `usethis` (your choice). This way the package website will have a
favicon.

``` r
usethis::use_logo("https://raw.githubusercontent.com/ropensci/logos/master/stickers/blue_short_hexsticker.png")
# but do not necessarily put it in the README as mentioned by `usethis`,
# your call!
pkgdown::build_favicon()
```

## Examples “in the wild”

  - [`cyphr`](https://ropensci.github.io/cyphr/)

  - [`drake`](https://ropensci.github.io/drake/)

  - [`riem`](https://ropensci.github.io/riem/)

  - [`ropenaq`](https://ropensci.github.io/ropenaq/)

  - [`rotl`](https://ropensci.github.io/rotl/)

  - [`stplanr`](https://ropensci.github.io/stplanr/)
