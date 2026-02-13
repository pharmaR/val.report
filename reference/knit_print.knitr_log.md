# Special handler for emitting knitr logs

Special handler for emitting knitr logs

## Usage

``` r
knit_print.knitr_log(x, ..., output_style = c("knitr", "quarto"))
```

## Arguments

- x:

  An R object to be printed

- ...:

  Additional arguments passed to the S3 method. Currently ignored,
  except two optional arguments `options` and `inline`; see the
  references below.

- output_style:

  Choose which command-line output format to use when logging. This will
  typically be set when a logger is created and should not need to be
  manually provided.
