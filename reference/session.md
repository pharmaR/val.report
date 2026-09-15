# Collect session information

Catalogs characteristics of the R session and execution environment.

## Usage

``` r
session()
```

## Value

A list with time, r_version, session_info, platform, machine, rng_kind,
capabilities, external_software and graphics_software information.

## Examples

``` r
s <- session()
str(s, 2)
#> List of 9
#>  $ time             : POSIXct[1:1], format: "2026-09-15 10:06:08"
#>  $ r_version        :List of 14
#>   ..$ platform      : chr "x86_64-pc-linux-gnu"
#>   ..$ arch          : chr "x86_64"
#>   ..$ os            : chr "linux-gnu"
#>   ..$ system        : chr "x86_64, linux-gnu"
#>   ..$ status        : chr ""
#>   ..$ major         : chr "4"
#>   ..$ minor         : chr "6.1"
#>   ..$ year          : chr "2026"
#>   ..$ month         : chr "06"
#>   ..$ day           : chr "24"
#>   ..$ svn rev       : chr "90187"
#>   ..$ language      : chr "R"
#>   ..$ version.string: chr "R version 4.6.1 (2026-06-24)"
#>   ..$ nickname      : chr "Happy Hop"
#>  $ session_info     :List of 14
#>   ..$ R.version  :List of 14
#>   ..$ platform   : chr "x86_64-pc-linux-gnu"
#>   ..$ locale     : chr "LC_CTYPE=C.UTF-8;LC_NUMERIC=C;LC_TIME=C.UTF-8;LC_COLLATE=C;LC_MONETARY=C.UTF-8;LC_MESSAGES=C.UTF-8;LC_PAPER=C.U"| __truncated__
#>   ..$ tzone      : chr "UTC"
#>   ..$ tzcode_type: chr "system (glibc)"
#>   ..$ running    : chr "Ubuntu 24.04.5 LTS"
#>   ..$ RNGkind    : chr [1:3] "Mersenne-Twister" "Inversion" "Rejection"
#>   ..$ basePkgs   : chr [1:7] "stats" "graphics" "grDevices" "utils" ...
#>   ..$ otherPkgs  :List of 1
#>   ..$ loadedOnly :List of 55
#>   ..$ matprod    : chr "default"
#>   ..$ BLAS       : chr "/usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3"
#>   ..$ LAPACK     : chr "/usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so"
#>   ..$ LA_version : chr "3.12.0"
#>   ..- attr(*, "class")= chr "sessionInfo"
#>  $ platform         :List of 8
#>   ..$ OS.type   : chr "unix"
#>   ..$ file.sep  : chr "/"
#>   ..$ dynlib.ext: chr ".so"
#>   ..$ GUI       : chr "X11"
#>   ..$ endian    : chr "little"
#>   ..$ pkgType   : chr "source"
#>   ..$ path.sep  : chr ":"
#>   ..$ r_arch    : chr ""
#>  $ machine          :List of 29
#>   ..$ double.eps               : num 2.22e-16
#>   ..$ double.neg.eps           : num 1.11e-16
#>   ..$ double.xmin              : num 2.23e-308
#>   ..$ double.xmax              : num 1.8e+308
#>   ..$ double.base              : int 2
#>   ..$ double.digits            : int 53
#>   ..$ double.rounding          : int 5
#>   ..$ double.guard             : int 0
#>   ..$ double.ulp.digits        : int -52
#>   ..$ double.neg.ulp.digits    : int -53
#>   ..$ double.exponent          : int 11
#>   ..$ double.min.exp           : int -1022
#>   ..$ double.max.exp           : int 1024
#>   ..$ integer.max              : int 2147483647
#>   ..$ sizeof.long              : int 8
#>   ..$ sizeof.longlong          : int 8
#>   ..$ sizeof.longdouble        : int 16
#>   ..$ sizeof.pointer           : int 8
#>   ..$ sizeof.time_t            : int 8
#>   ..$ longdouble.eps           : num 1.08e-19
#>   ..$ longdouble.neg.eps       : num 5.42e-20
#>   ..$ longdouble.digits        : int 64
#>   ..$ longdouble.rounding      : int 5
#>   ..$ longdouble.guard         : int 0
#>   ..$ longdouble.ulp.digits    : int -63
#>   ..$ longdouble.neg.ulp.digits: int -64
#>   ..$ longdouble.exponent      : int 15
#>   ..$ longdouble.min.exp       : int -16382
#>   ..$ longdouble.max.exp       : int 16384
#>  $ rng_kind         : chr [1:3] "Mersenne-Twister" "Inversion" "Rejection"
#>  $ capabilities     :List of 19
#>   ..$ jpeg       : logi TRUE
#>   ..$ png        : logi TRUE
#>   ..$ tiff       : logi TRUE
#>   ..$ tcltk      : logi TRUE
#>   ..$ X11        : logi FALSE
#>   ..$ aqua       : logi FALSE
#>   ..$ http/ftp   : logi TRUE
#>   ..$ sockets    : logi TRUE
#>   ..$ libxml     : logi FALSE
#>   ..$ fifo       : logi TRUE
#>   ..$ cledit     : logi FALSE
#>   ..$ iconv      : logi TRUE
#>   ..$ NLS        : logi TRUE
#>   ..$ Rprof      : logi TRUE
#>   ..$ profmem    : logi TRUE
#>   ..$ cairo      : logi TRUE
#>   ..$ ICU        : logi TRUE
#>   ..$ long.double: logi TRUE
#>   ..$ libcurl    : logi TRUE
#>  $ external_software:List of 11
#>   ..$ zlib      : chr "1.3"
#>   ..$ bzlib     : chr "1.0.8, 13-Jul-2019"
#>   ..$ xz        : chr "5.4.5"
#>   ..$ libdeflate: chr "1.19"
#>   ..$ zstd      : chr "1.5.5"
#>   ..$ PCRE      : chr "10.42 2022-12-11"
#>   ..$ ICU       : chr "74.2"
#>   ..$ TRE       : chr "TRE 0.8.0 R_fixes (BSD)"
#>   ..$ iconv     : chr "glibc 2.39"
#>   ..$ readline  : chr "8.2"
#>   ..$ BLAS      : chr "/usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3"
#>  $ graphics_software:List of 6
#>   ..$ cairo  : chr "1.18.0"
#>   ..$ cairoFT: chr ""
#>   ..$ pango  : chr "1.52.1"
#>   ..$ libpng : chr "1.6.43"
#>   ..$ jpeg   : chr "8.0"
#>   ..$ libtiff: chr "LIBTIFF, Version 4.5.1"
```
