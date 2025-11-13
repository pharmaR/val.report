# This report is fully automated and builds on [rhub/ref-image](https://hub.docker.com/r/rhub/ref-image) image.

# This report is fully automated and builds on [rhub/ref-image](https://hub.docker.com/r/rhub/ref-image) image.

2025-11-13 12:00:00

# Context

Documents the installation of this package on an open source R
environment, focusing on:

- Installation environment description
- Testing coverage

It is limited to assess whether unit tests and documentation are present
and can execute without error. An assessment would be required that the
tests and documentation are meaningful.

# Package dplyr

## Metric based risk assessment

The following metrics are derived from the `riskmetric` R package.

1 year

### 17965873

Downloads

Reverse Dependencies

### 5458

License

### MIT + file LICENSE

Origin

### NA

# Installation environment

## System Info

| Field          | Value                        |
|:---------------|:-----------------------------|
| Image          | rhub/ref-image               |
| OS             | Windows 11 x64 (build 22631) |
| Platform       | x86_64-w64-mingw32           |
| System         | x86_64, mingw32              |
| Execution Time | 2025-11-13 14:29:20 UTC      |

**System information**. Table about the system used to check the
package.

## R Session Info

Session info

``` details
R version 4.5.2 (2025-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 22631)

Matrix products: default
  LAPACK version 3.12.1

locale:
[1] LC_COLLATE=Spanish_Spain.utf8  LC_CTYPE=Spanish_Spain.utf8   
[3] LC_MONETARY=Spanish_Spain.utf8 LC_NUMERIC=C                  
[5] LC_TIME=Spanish_Spain.utf8    

time zone: Europe/Madrid
tzcode source: internal

attached base packages:
[1] tools     stats     graphics  grDevices utils     datasets  methods  
[8] base     

other attached packages:
[1] val.report_0.0.0.9006 knitr_1.50           

loaded via a namespace (and not attached):
 [1] jsonlite_2.0.0      compiler_4.5.2      BiocManager_1.30.26
 [4] Rcpp_1.1.0          xml2_1.4.1          covr_3.6.5         
 [7] urltools_1.7.3.1    callr_3.7.6         riskmetric_0.2.5   
[10] triebeard_0.4.1     yaml_2.3.10         fastmap_1.2.0      
[13] R6_2.6.1            curl_7.0.0          htmlwidgets_1.6.4  
[16] backports_1.5.0     tibble_3.3.0        cranlogs_2.1.1     
[19] reactable_0.4.4     pillar_1.11.1       rlang_1.1.6        
[22] cachem_1.1.0        reactR_0.6.1        xfun_0.54          
[25] fs_1.6.6            lazyeval_0.2.2      pkgload_1.4.1      
[28] rex_1.2.1           memoise_2.0.1       cli_3.6.5          
[31] magrittr_2.0.4      crosstalk_1.2.2     ps_1.9.1           
[34] digest_0.6.37       processx_3.8.6      rstudioapi_0.17.1  
[37] remotes_2.5.0.9000  devtools_2.4.6      lifecycle_1.0.4    
[40] vctrs_0.6.5         evaluate_1.0.5      glue_1.8.0         
[43] sessioninfo_1.2.3   pkgbuild_1.4.8      rmarkdown_2.30     
[46] purrr_1.1.0         httr_1.4.7          pkgconfig_2.0.3    
[49] usethis_3.2.1       ellipsis_0.3.2      htmltools_0.5.8.1  
```

Platform

``` details
     OS.type     file.sep   dynlib.ext          GUI       endian      pkgType 
   "windows"          "/"       ".dll"      "RTerm"     "little" "win.binary" 
    path.sep       r_arch 
         ";"        "x64" 
```

R's capabilities

``` details
       jpeg         png        tiff       tcltk         X11        aqua 
       TRUE        TRUE        TRUE        TRUE       FALSE       FALSE 
   http/ftp     sockets      libxml        fifo      cledit       iconv 
       TRUE        TRUE       FALSE        TRUE       FALSE        TRUE 
        NLS       Rprof     profmem       cairo         ICU long.double 
       TRUE        TRUE        TRUE        TRUE        TRUE        TRUE 
    libcurl 
       TRUE 
```

External software

``` details
                     zlib                     bzlib                        xz 
                  "1.3.1"      "1.0.8, 13-Jul-2019"                   "5.8.1" 
               libdeflate                      PCRE                       ICU 
                   "1.24"        "10.46 2025-08-27"                    "77.1" 
                      TRE                     iconv                  readline 
"TRE 0.8.0 R_fixes (BSD)"               "win_iconv"                        "" 
                     BLAS 
                       "" 
```

Graphics external software

``` details
                   cairo                  cairoFT                    pango 
                "1.18.4"                       ""                       "" 
                  libpng                     jpeg                  libtiff 
                "1.6.50"                    "9.6" "LIBTIFF, Version 4.7.1" 
```

Numerical characteristics of the machine

``` details
               double.eps            double.neg.eps               double.xmin 
             2.220446e-16              1.110223e-16             2.225074e-308 
              double.xmax               double.base             double.digits 
            1.797693e+308              2.000000e+00              5.300000e+01 
          double.rounding              double.guard         double.ulp.digits 
             5.000000e+00              0.000000e+00             -5.200000e+01 
    double.neg.ulp.digits           double.exponent            double.min.exp 
            -5.300000e+01              1.100000e+01             -1.022000e+03 
           double.max.exp               integer.max               sizeof.long 
             1.024000e+03              2.147484e+09              4.000000e+00 
          sizeof.longlong         sizeof.longdouble            sizeof.pointer 
             8.000000e+00              1.600000e+01              8.000000e+00 
            sizeof.time_t            longdouble.eps        longdouble.neg.eps 
             8.000000e+00              1.084202e-19              5.421011e-20 
        longdouble.digits       longdouble.rounding          longdouble.guard 
             6.400000e+01              5.000000e+00              0.000000e+00 
    longdouble.ulp.digits longdouble.neg.ulp.digits       longdouble.exponent 
            -6.300000e+01             -6.400000e+01              1.500000e+01 
       longdouble.min.exp        longdouble.max.exp 
            -1.638200e+04              1.638400e+04 
```

Random number generation process

``` details
[1] "Mersenne-Twister" "Inversion"        "Rejection"       
```

## Information about the environment

Environmental and options variables affect how package checks and
software in it might behave.

Environmental variables when running this report

``` details
__PSLockDownPolicy      0
_R_CHECK_LENGTH_1_LOGIC2_
                        warn
_R_CHECK_ORPHANED_      true
_R_CHECK_S3_METHODS_SHOW_POSSIBLE_ISSUES_
                        true
_R_CHECK_SYSTEM_CLOCK_
                        FALSE
_R_CHECK_THINGS_IN_TEMP_DIR_
                        TRUE
_R_COMPARE_LANG_OBJECTS
                        eqonly
_R_INSTALL_PACKAGES_ELAPSED_TIMEOUT_
                        0
_R_USE_PIPEBIND_        TRUE
ALLUSERSPROFILE         C:\ProgramData
AU-PREFIX               Madrid-IT
BPPDOMAIN_MANAGER_ASM   EdrDotNet, Version+165.0.0.0, Culture+neutral,
                        PublicKeyToken+da1b3922653ea916
BPPDOMAIN_MANAGER_TYPE
                        EdrDotNet.EdrAppDomainManager
CLICOLOR_FORCE          1
CommonProgramFiles      C:\Program Files\Common Files
CommonProgramFiles(x86)
                        C:\Program Files (x86)\Common Files
CommonProgramW6432      C:\Program Files\Common Files
COMPUTERNAME            RMAMWM41853
ComSpec                 C:\WINDOWS\system32\cmd.exe
CONNECT_API_KEY         dOIulr7Q4ZHoEIMhyH43RJ7jdfbM6gOl
CURL_CA_BUNDLE          C:/PROGRA~1/R/R-45~1.2/etc/curl-ca-bundle.crt
DENO_DOM_PLUGIN         C:\Users\sanchosl\AppData\Local\Programs\Quarto\bin\tools\x86_64\deno_dom\plugin.dll
DENO_NO_UPDATE_CHECK    1
DENO_TLS_CA_STORE       system,mozilla
DISPLAY                 :0
DriverData              C:\Windows\System32\Drivers\DriverData
EFC_12056               1
GFORTRAN_STDERR_UNIT    -1
GFORTRAN_STDOUT_UNIT    -1
GIT_ASKPASS             rpostback-askpass
GIT_LFS_PATH            C:\Program Files\Git LFS
GPPSiteSettings         \\Rmamsapp01\gpp
HOME                    C:\Users\sanchosl\Documents
HOMEDRIVE               C:
HOMEPATH                \Users\sanchosl
IniLocation             C:\Users\sanchosl\AppData\Local\Roche\Ini
JABRA_NATIVE_BLUETOOTH
                        true
LANGUAGE                en
LIBJABRA_TRACE_LEVEL    INFO
LOCALAPPDATA            C:\Users\sanchosl\AppData\Local
LOGONSERVER             \\RMAMSEMEA01
MPLENGINE               tkAgg
MSYS2_ENV_CONV_EXCL     R_ARCH
NEXTHINK                C:\Program Files\Nexthink\Collector
NO_COLOR                TRUE
NOT_CRAN                true
NUMBER_OF_PROCESSORS    12
ORCID_ID                0000-0001-9747-2570
ORIGINAL_XDG_CURRENT_DESKTOP
                        undefined
OS                      Windows_NT
PATH                    C:\rtools45/x86_64-w64-mingw32.static.posix/bin;C:\rtools45/usr/bin;C:\rtools45\x86_64-w64-mingw32.static.posix\bin;C:\rtools45\usr\bin;C:\Program
                        Files\R\R-4.5.2\bin\x64;C:\Program Files
                        (x86)\Java\jre6\bin;C:\Program
                        Files\Java\jre6\bin;C:\Windows\System32;C:\Windows;C:\Windows\System32\wbem;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Windows\System32\OpenSSH;C:\Program
                        Files\WindowsPowerShell\scripts\HP.ClientScriptLibrary;C:\Program
                        Files\Microsoft VS Code\bin;C:\Program
                        Files\rig;C:\Program Files\R\bin;C:\Program
                        Files\Git\cmd;C:\Program Files
                        (x86)\GnuPG\bin;C:\Program
                        Files\Meld;C:\Program
                        Files\smimesign;C:\Program Files\Git
                        LFS;C:\Program
                        Files\RedHat\Podman;C:\Users\sanchosl\AppData\Roaming\TinyTeX\bin\windows;C:\Users\sanchosl\AppData\Local\Programs\Quarto\bin;C:\Users\sanchosl\.local\bin;C:\Users\sanchosl\AppData\Local\Microsoft\WindowsApps;C:\Users\sanchosl\AppData\Local\GitHubDesktop\bin;C:\Users\sanchosl\AppData\Local\Packages\PythonSoftwareFoundation.Python3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts;C:\Users\sanchosl\AppData\Local\Pandoc;C:\Users\sanchosl\AppData\Local\Programs\MiKTeX\miktex\bin\x64;C:\Users\sanchosl\AppData\Local\Microsoft\WinGet\Packages\Schniz.fnm_Microsoft.Winget.Source_8wekyb3d8bbwe;C:\Users\sanchosl\.git-secrets;C:\Users\sanchosl\AppData\Local\packages\PythonSoftwareFoundation.Python.3.12_qbz5n2kfra8p0\LocalCache\local-packages\Python312\Scripts;C:\Users\sanchosl\AppData\Local\Programs\Positron\bin;C:\Users\sanchosl\AppData\Local\Programs\Ollama;C:\Users\sanchosl\AppData\Local\Programs\Quarto\bin;C:\Program
                        Files\RStudio\resources\app\bin\postback
PATHEXT                 .COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC
PKGLOAD_PARENT_TEMPDIR
                        C:\Users\sanchosl\AppData\Local\Temp\RtmpEFVMfU
PROCESSOR_ARCHITECTURE
                        AMD64
PROCESSOR_IDENTIFIER    Intel64 Family 6 Model 154 Stepping 4,
                        GenuineIntel
PROCESSOR_LEVEL         6
PROCESSOR_REVISION      9a04
PROCESSX_PS793c4c2aae6_1763044152
                        YES
ProgramData             C:\ProgramData
ProgramW6432            C:\Program Files
PROMPT                  $P$G
PSModulePath            C:\Program
                        Files\WindowsPowerShell\Modules;C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
PUBLIC                  C:\Users\Public
PYTHONIOENCODING        utf-8
QUARTO_BIN_PATH         C:\Users\sanchosl\AppData\Local\Programs\Quarto\bin
QUARTO_DENO             C:\Users\sanchosl\AppData\Local\Programs\Quarto\bin\tools\x86_64\deno
QUARTO_DOCUMENT_FILE    validation_report_dplyr_v1.1.4.qmd
QUARTO_DOCUMENT_PATH    pkgdown\assets
QUARTO_EXECUTE_INFO     C:\Users\sanchosl\AppData\Local\Temp\quarto-sessionbc32760f5ec0b6b5\b0301d4c4cfecfd\6e009d582bd3ff19
QUARTO_PROJECT_ROOT     C:\Code\Rprojects\validation\val.report\pkgdown\assets
QUARTO_SHARE_PATH       C:\Users\sanchosl\AppData\Local\Programs\Quarto\share
R_ALWAYS_INSTALL_TESTS
                        0
R_ARCH                  /x64
R_CHECK_CODETOOLS_PROFILE
                        suppressLocalUnused=FALSE
R_CLI_HAS_HYPERLINK_IDE_HELP
                        true
R_CLI_HAS_HYPERLINK_IDE_RUN
                        true
R_CLI_HAS_HYPERLINK_IDE_VIGNETTE
                        true
R_COMPILED_BY           gcc 14.3.0
R_DOC_DIR               C:/PROGRA~1/R/R-45~1.2/doc
R_HOME                  C:/PROGRA~1/R/R-45~1.2
R_INCLUDE_DIR           C:/PROGRA~1/R/R-45~1.2/include
R_IniPath               C:\Users\sanchosl\AppData\Local\Roche\Ini
R_KEEP_PKG_SOURCE       yes
R_LIBCURL_SSL_REVOKE_BEST_EFFORT
                        TRUE
R_LIBS_SITE             C:/PROGRA~1/R/R-45~1.2/site-library
R_LIBS_USER             C:\Users\sanchosl\AppData\Local/R/win-library/4.5
R_PLATFORM              
R_RTOOLS45_PATH         C:\rtools45/x86_64-w64-mingw32.static.posix/bin;C:\rtools45/usr/bin
R_RUNTIME               ucrt
R_SHARE_DIR             C:/PROGRA~1/R/R-45~1.2/share
R_TIMEOUT               100
RMARKDOWN_MATHJAX_PATH
                        C:/Program
                        Files/RStudio/resources/app/resources/mathjax-27
RS_LOCAL_PEER           \\.\pipe\46387-rsession
RS_LOG_LEVEL            WARN
RS_RPOSTBACK_PATH       C:/Program
                        Files/RStudio/resources/app/bin/rpostback.exe
RS_SHARED_SECRET        6b77b9c8-d608-4108-b9aa-4feff23e062c
RSTUDIO                 1
RSTUDIO_CLI_HYPERLINKS
                        true
RSTUDIO_CONSOLE_COLOR   256
RSTUDIO_CONSOLE_WIDTH   131
RSTUDIO_DESKTOP_EXE     C:\Program Files\RStudio\rstudio.exe
RSTUDIO_PANDOC          C:/Program
                        Files/RStudio/resources/app/bin/quarto/bin/tools
RSTUDIO_PROGRAM_MODE    desktop
RSTUDIO_SESSION_PID     31036
RSTUDIO_SESSION_PORT    46387
RSTUDIO_USER_IDENTITY   sanchosl
RSTUDIO_WINUTILS        C:/Program
                        Files/RStudio/resources/app/bin/winutils
RTOOLS43_HOME           C:\rtools43
RTOOLS44_HOME           C:\rtools44
RTOOLS45_HOME           C:\rtools45
SESSIONNAME             Console
SF_PARTNER              posit_rstudio
SPARK_CONNECT_USER_AGENT
                        posit-rstudio
SSH_ASKPASS             rpostback-askpass
SystemDrive             C:
SystemRoot              C:\WINDOWS
TEMP                    C:\Users\sanchosl\AppData\Local\Temp
TERM                    xterm-256color
TESTING_DEPTH           5
TMP                     C:\Users\sanchosl\AppData\Local\Temp
UATDATA                 C:\WINDOWS\CCM\UATData\D9F8C395-CAB8-491d-B8AC-179A1FE1BE77
windir                  C:\WINDOWS
ZES_ENABLE_SYSMAN       1
```

These are the options set to generate the report

``` details
$add.smooth
[1] TRUE

$browserNLdisabled
[1] FALSE

$callr.condition_handler_cli_message
function (msg) 
{
    custom_handler <- getOption("cli.default_handler")
    if (is.function(custom_handler)) {
        custom_handler(msg)
    }
    else {
        cli_server_default(msg)
    }
}
<bytecode: 0x0000024759d91e98>
<environment: namespace:cli>

$catch.script.errors
[1] FALSE

$CBoundsCheck
[1] FALSE

$check.bounds
[1] FALSE

$citation.bibtex.max
[1] 1

$continue
[1] "+ "

$contrasts
        unordered           ordered 
"contr.treatment"      "contr.poly" 

$covr.covrignore
[1] ".covrignore"

$covr.exclude_end
#[[:space:]]*nocov[[:space:]]*end

$covr.exclude_pattern
#[[:space:]]*nocov

$covr.exclude_start
#[[:space:]]*nocov[[:space:]]*start

$covr.flags
          CFLAGS         CXXFLAGS       CXX1XFLAGS       CXX11FLAGS 
"-O0 --coverage" "-O0 --coverage" "-O0 --coverage" "-O0 --coverage" 
      CXX14FLAGS       CXX17FLAGS       CXX20FLAGS           FFLAGS 
"-O0 --coverage" "-O0 --coverage" "-O0 --coverage" "-O0 --coverage" 
         FCFLAGS            FLIBS     SHLIB_LIBADD 
"-O0 --coverage"         "-lgcov"     "--coverage" 

$covr.gcov
                                       gcov 
"C:\\rtools45\\X86_64~1.POS\\bin\\gcov.exe" 

$covr.icov
codecov 
     "" 

$covr.icov_flags
                CFLAGS               CXXFLAGS             CXX1XFLAGS 
"-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" 
            CXX11FLAGS             CXX14FLAGS             CXX17FLAGS 
"-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" 
            CXX20FLAGS                 FFLAGS                FCFLAGS 
"-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" 
               LDFLAGS           SHLIB_LIBADD 
"-O0 -prof-gen=srcpos" "-O0 -prof-gen=srcpos" 

$covr.icov_prof
profmerge 
       "" 

$covr.record_tests
[1] TRUE

$defaultPackages
[1] "datasets"  "utils"     "grDevices" "graphics"  "stats"     "methods"  

$demo.ask
[1] "default"

$deparse.cutoff
[1] 60

$device
function (width = 7, height = 7, ...) 
{
    grDevices::pdf(NULL, width, height, ...)
}
<bytecode: 0x000002475acbd990>
<environment: namespace:knitr>

$device.ask.default
[1] FALSE

$devtools.ellipsis_action
function (message = NULL, class = NULL, ..., body = NULL, footer = NULL, 
    parent = NULL, use_cli_format = NULL, .inherit = NULL, .frequency = c("always", 
        "regularly", "once"), .frequency_id = NULL, .subclass = deprecated()) 
{
    message <- validate_signal_args(message, class, NULL, .subclass, 
        "warn")
    message_info <- cnd_message_info(message, body, footer, caller_env(), 
        use_cli_format = use_cli_format)
    message <- message_info$message
    extra_fields <- message_info$extra_fields
    use_cli_format <- message_info$use_cli_format
    .frequency <- arg_match0(.frequency, c("always", "regularly", 
        "once"))
    if (!needs_signal(.frequency, .frequency_id, warning_freq_env, 
        "rlib_warning_verbosity")) {
        return(invisible(NULL))
    }
    if (!is_null(parent)) {
        if (is_null(.inherit)) {
            .inherit <- !inherits(parent, "error")
        }
        extra_fields$rlang <- c(extra_fields$rlang, list(inherit = .inherit))
    }
    cnd <- warning_cnd(class, message = message, !!!extra_fields, 
        use_cli_format = use_cli_format, parent = parent, ...)
    cnd$footer <- c(cnd$footer, message_freq(message, .frequency, 
        "warning"))
    local_long_messages()
    warning(cnd)
}
<bytecode: 0x0000024754b80a88>
<environment: namespace:rlang>

$devtools.install.args
[1] ""

$devtools.path
[1] "~/R-dev"

$digits
[1] 7

$echo
[1] FALSE

$editor
[1] "notepad"

$encoding
[1] "native.enc"

$example.ask
[1] "default"

$expressions
[1] 5000

$help.search.types
[1] "vignette" "demo"     "help"    

$help.try.all.packages
[1] FALSE

$help_type
[1] "html"

$htmltools.preserve.raw
[1] TRUE

$HTTPUserAgent
[1] "R (4.5.2 x86_64-w64-mingw32 x86_64 mingw32)"

$httr_oauth_cache
[1] NA

$httr_oob_default
[1] FALSE

$install.packages.compile.from.source
[1] "interactive"

$internet.info
[1] 2

$keep.parse.data
[1] TRUE

$keep.parse.data.pkgs
[1] FALSE

$keep.source
[1] FALSE

$keep.source.pkgs
[1] TRUE

$knitr.in.progress
[1] TRUE

$locatorBell
[1] TRUE

$mailer
[1] "mailto"

$matprod
[1] "default"

$max.contour.segments
[1] 25000

$max.print
[1] 99999

$menu.graphics
[1] TRUE

$na.action
[1] "na.omit"

$nwarnings
[1] 50

$OutDec
[1] "."

$pager
[1] "internal"

$papersize
[1] "a4"

$PCRE_limit_recursion
[1] NA

$PCRE_study
[1] FALSE

$PCRE_use_JIT
[1] TRUE

$pdfviewer
[1] "C:/PROGRA~1/R/R-45~1.2/bin/x64/open.exe"

$pkgType
[1] "both"

$prompt
[1] "> "

$repos
                                          P3M 
"https://packagemanager.posit.co/cran/latest" 
                                         CRAN 
                "https://cloud.r-project.org" 

$riskmetric.github_api_host
[1] "https://api.github.com"

$riskmetric.gitlab_api_host
[1] "https://gitlab.com/api/v4"

$riskmetric.per_package_request
[1] FALSE

$rlang_trace_top_env
<environment: R_GlobalEnv>

$scipen
[1] 0

$show.coef.Pvalues
[1] TRUE

$show.error.messages
[1] TRUE

$show.signif.stars
[1] TRUE

$showErrorCalls
[1] TRUE

$showNCalls
[1] 50

$showWarnCalls
[1] FALSE

$str
$str$strict.width
[1] "no"

$str$digits.d
[1] 3

$str$vec.len
[1] 4

$str$list.len
[1] 99

$str$deparse.lines
NULL

$str$drop.deparse.attr
[1] TRUE

$str$formatNum
function (x, ...) 
format(x, trim = TRUE, drop0trailing = TRUE, ...)
<environment: 0x000002475860f5a0>


$str.dendrogram.last
[1] "`"

$tikzMetricsDictionary
[1] "validation_report_dplyr_v1.1.4-tikzDictionary"

$timeout
[1] 60

$try.outFile
A connection with                    
description ""      
class       "file"  
mode        "w+b"   
text        "binary"
opened      "opened"
can read    "yes"   
can write   "yes"   

$ts.eps
[1] 1e-05

$ts.S.compat
[1] FALSE

$unzip
[1] "internal"

$useFancyQuotes
[1] FALSE

$verbose
[1] FALSE

$warn
[1] 0

$warning.length
[1] 1000

$warnPartialMatchArgs
[1] FALSE

$warnPartialMatchAttr
[1] FALSE

$warnPartialMatchDollar
[1] FALSE

$width
[1] 80

$windowsTimeouts
[1] 100 500
```
