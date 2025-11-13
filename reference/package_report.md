# Reports about a package

Reports about a package

## Usage

``` r
package_report(
  package_name,
  package_version,
  package = NULL,
  template_path = system.file("report/package", package = "val.report"),
  output_format = "all",
  params = list(),
  ...
)
```

## Arguments

- package_name:

  Package name.

- package_version:

  Package version number.

- package:

  Path where to find a package source to retrieve name and version
  number.

- template_path:

  Path to a custom quarto template file

- output_format:

  Output format for the report. Default is "all".

- params:

  A list of execute parameters passed to the template

- ...:

  Additional arguments passed to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)

## Value

A path to the reports generated, called by its side effects.

## Details

Please include source as part of `params` content. Source is returned
after calling function
[`riskmetric::pkg_ref`](https://pharmar.github.io/riskmetric/reference/pkg_ref.html)
before the risk assessment is executed

## Examples

``` r
pr <- package_report(
  package_name = "dplyr",
  package_version = "1.1.4",
  params = list(
    assessment_path = system.file("assessments/dplyr.rds", package = "val.report"),
    image = "rhub/ref-image")
)
#> Error in normalizePath(params$assessment_path, mustWork = TRUE): path[1]="": No such file or directory
pr
#> Error: object 'pr' not found
file.remove(pr)
#> Error: object 'pr' not found
```
