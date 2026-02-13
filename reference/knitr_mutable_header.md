# Create mutable header object

Inject a custom document rendering hook into the knitr engine and return
a mutable environment that we can modify, which will be used to update
the knitr document header upon render completion.

## Usage

``` r
knitr_mutable_header()
```

## Note

`val.report` `knitr` utilities are exported for use in reports
maintained by the R Validation Hub. If you choose to use these functions
for other purposes, be aware that these are not considered stable for
broader use.
