# val.report

*documents package validation checks*

## Installation

You can install the development version of val.report from
[GitHub](https://github.com/pharmaR/val.report) with:

``` r

# install.packages("pak")
pak::pak("pharmaR/val.report")
```

## Quick Start

Generate reports easily

``` r

library(val.report)

options(
  width = 80L,
  val.meter.logs = TRUE,
  val.meter.policy = val.meter::policy(permissions = TRUE)
)

package_report("praise")
```

Because we’ve given `val.meter` permission to download packages from the
network, passing simply a package name will pull the latest version from
a package repository for evaluation.

If you’d like to be more prescriptive, you can also pass a local source
code directory or package archive (`.tar.gz` or `.zip`).
`package_report` accepts any input that can be converted into a
[`val.meter::pkg`](https://pharmar.github.io/val.meter/reference/pkg.html)
object.

> \[!NOTE\]
>
> We are continuing to add more supported input types. Currently,
> locally source code directories have the best support to cover the
> most concrete use case. We plan to improve support for more
> user-friendly inputs such as packages by name and `.tar.gz` by url.

## For Developers

This repository vendors the R Validation Hub quarto template, which is
included as a `git` submodule. Submodules require slightly different
syntax in order to be included. When cloning, be sure to use:

``` sh
git clone --recurse-submodules ...  
```
