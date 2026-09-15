# Create a knitr log function

Sets necessary knitr hooks and returns a logging function that will emit
messages to the console during knitting.

## Usage

``` r
knitr_logger()
```

## Value

A `function` accepting `...` arguments, which will be used for printing
out to the console while rendering the knitr document. Character values
are logged directly, while any other object is printed as though being
printed to the console. To render character values as they would be
printed, mark them as "AsIs" using
[`I()`](https://rdrr.io/r/base/AsIs.html).

## Note

`val.report` `knitr` utilities are exported for use in reports
maintained by the R Validation Hub. If you choose to use these functions
for other purposes, be aware that these are not considered stable for
broader use.

## Examples

``` r
knitr_logger()
#> function (...) 
#> {
#>     knitr::knit_print(structure(list(...), class = c("knitr_log", 
#>         "list")), output_style = output_style)
#> }
#> <bytecode: 0x5613c25a8d78>
#> <environment: 0x5613c25a9440>
```
