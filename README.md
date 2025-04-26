# rotemplate <a href='https://docs.ropensci.org/rotemplate'><img src='man/figures/logo.png' align="right" height="134.5" /></a>

rotemplate provides **a custom pkgdown template** for rOpenSci packages. We
use this to render sites at `https://docs.ropensci.org`. Please don’t
use it for your own package if it’s not an rOpenSci package (i.e. only
use it for packages listed on <https://ropensci.org/packages/>).

Inspired by [tidytemplate](https://github.com/tidyverse/tidytemplate/)
and [lockedatapkg](https://github.com/lockedatapublished/lockedatapkg).

## How to use `rotemplate`

Documentation for rOpenSci packages will automatically be generated from
your default branch and published to <https://docs.ropensci.org>. You
don’t need to do anything to make this work. To test your site locally use:

``` r
library(rotemplate)
#install.packages("yourpkg")
rotemplate::build_ropensci_docs("path/to/yourpkg")
```

Preferences can be configured as usual via the `_pkgdown.yml` file
as described in the pkgdown documentation.

If your website is not deploying or you run into another problem, please
open an issue in the [rotemplate](https://github.com/ropensci-org/rotemplate)
repository.

## How it works

The R-universe [build workflow](https://github.com/r-universe/workflows/blob/v1/.github/workflows/build.yml)
automatically invokes the rotemplate [action.yml](action.yml) script on each
update of a packages in ropensci. You don't need to do anything for this.
However, if you want to test-build the pkgdown site in your own package CI, 
you could add the following test workflow to your package repository:

```yml
on:
  push:
  pull_request:

name: Test-docs

jobs:
  Test-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: ropensci-org/rotemplate@main
```

This will run exactly the same script to build the ropensci pkgdown site, and
store it as an GHA artifact where you can download it to view it locally.

### Math rendering

Please refer to [pkgdown documentation](https://pkgdown.r-lib.org/dev/articles/customise.html#math-rendering).


## Example sites

-   [`cyphr`](https://docs.ropensci.org/cyphr/)

-   [`drake`](https://docs.ropensci.org/drake/)

-   [`riem`](https://docs.ropensci.org/riem/)

-   [`rotl`](https://docs.ropensci.org/rotl/)

-   [`stplanr`](https://docs.ropensci.org/stplanr/)

-   [`visdat`](http://visdat.njtierney.com/)

-   [`magick`](https://docs.ropensci.org/magick/)
