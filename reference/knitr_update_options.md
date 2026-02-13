# Handler for complex option passing through from a quarto parameter

Importantly, handles
[`S7::new_class()`](https://rconsortium.github.io/S7/reference/new_class.html)
objects which cannot be passed through as a `quarto` command-line
parameter because they can not be deparsed. This helper allows passing
arbitrary expressions using the `!expr` prefix, which is standardized by
`yaml`.

## Usage

``` r
knitr_update_options(opts, envir = parent.frame())
```

## Arguments

- opts:

  A `list` of options. For any non-serializable values that would fail
  using your preferred interface to `knitr`, you may pass them as an
  expression string such as `"!expr mtcars"`. Notably,
  [`quarto::quarto_render`](https://quarto-dev.github.io/quarto-r/reference/quarto_render.html),
  which attempts to serialize objects for passing to the command-line
  `quarto`, will fail for such objects and requires the `"!expr"`
  prefix.

- envir:

  `environment` in which expressions should be evaluated.

## Value

The `opts` list after parsing any complex expressions. This function is
used primarily for modifying the global state by calling
[`options()`](https://rdrr.io/r/base/options.html)

## Note

`val.report` `knitr` utilities are exported for use in reports
maintained by the R Validation Hub. If you choose to use these functions
for other purposes, be aware that these are not considered stable for
broader use.

## Examples

``` r
# in a knitr document, we'll imagine we have some `params` object that we
# want to use to set options:
params <- list(options = list(
  # most objects can be passed just fine
  example_1 = list(a = 1L, b = "two"),

  # but objects that cannot be deserialized from their serialized (using,
  # for example [`dput()`], [`dump()`], and [`deparse()`]) expression would
  # fail as they are attempted to be passed to the `quarto` command-line
  # utility.
  complex_option = '!expr S7::new_class("example")()'
))

knitr_update_options(params$options)
#> $example_1
#> $example_1$a
#> [1] 1
#> 
#> $example_1$b
#> [1] "two"
#> 
#> 
#> $complex_option
#> <example>
#> 
```
