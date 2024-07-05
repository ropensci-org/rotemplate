# rotemplate <a href='https://docs.ropensci.org/rotemplate'><img src='man/figures/logo.png' align="right" height="134.5" /></a>

rotemplate provides a custom pkgdown template for rOpenSci packages. We
use this to render sites at `https://docs.ropensci.org`. Please don’t
use it for your own package if it’s not an rOpenSci package (i.e. only
use it for packages listed on <https://ropensci.org/packages/>).

Inspired by [tidytemplate](https://github.com/tidyverse/tidytemplate/)
and [lockedatapkg](https://github.com/lockedatapublished/lockedatapkg).

## How to use `rotemplate`

Documentation rOpenSci packages will automatically be generated from
your master branch and published to <https://docs.ropensci.org>. You
don’t have to do anything to make this work. If you want to test your
site locally use this:

``` r
library(rotemplate)
#install.packages("yourpkg")
rotemplate::build_ropensci_docs("path/to/yourpkg")
```

Everything else can be configured as usual via the `_pkgdown.yml` file
as described in the pkgdown documentation.

If your website is not deploying or you run into another problem, please
open an issue in the [ropensci/docs](https://github.com/ropensci/docs)
repository.

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
