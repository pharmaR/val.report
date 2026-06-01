# Generates an R Validation Hub package report

Generates an R Validation Hub package report

## Usage

``` r
package_report(
  package = NULL,
  session = NULL,
  options = val_options(plus = c("width")),
  template = NULL,
  output_dir = getwd(),
  quiet = FALSE,
  ...
)
```

## Arguments

- package:

  A package name, source code file path, url or path to an `Rds` file of
  a
  [val.meter::pkg](https://pharmar.github.io/val.meter/reference/pkg.html)
  object . For details on accepted inputs, see
  [val.meter::pkg](https://pharmar.github.io/val.meter/reference/pkg.html).

- session:

  A `list` of session information or a path to an `Rds` of a
  [session](https://pharmar.github.io/val.report/reference/session.md)
  object. If `NULL`, the session information will be derived when the
  package metrics are calculated. Will error if only one of `package` or
  `session` is provided as a `Rds` file.

- options:

  Additional options to use when deriving package metrics. By default,
  inherits any `val.*` options as well as a select few global
  environment variables.

- template:

  A `quarto` template file to use. See details for more information.

- output_dir:

  `character(1L)` directory path in which rendered files should be
  generated. Defaults to the current working directory.

- quiet:

  `logical(1L)` flag indicating whether output should be emitted to the
  console when rendering the report.

- ...:

  Additional arguments passed to
  [`quarto::quarto_render()`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html)

## Details

This function uses a pre-built `quarto` extension which provides its own
template document. To replace the existing template with your own
without further changes, ensure that your template exposes the same
parameters. Custom templates likely want to begin as a copy of the
original report.

## Examples

``` r
if (FALSE) { # \dontrun{
options(
  width = 80L,
  val.meter.logs = TRUE,
  val.meter.policy = val.meter::policy(permissions = TRUE)
)

package_report(package = "path/to/package")
} # }
```
