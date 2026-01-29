#' @importFrom utils packageName
roxygen2_knitr_note <- function() {
  sprintf(
    paste(
      "`%s` `knitr` utilities are exported for use in",
      "reports maintained by the R Validation Hub.",
      "If you choose to use these functions for other purposes, be aware",
      "that these are not considered stable for broader use."
    ),
    packageName()
  )
}

#' Handler for complex option passing through from a quarto parameter
#'
#' Importantly, handles [`S7::new_class()`] objects which cannot be passed
#' through as a `quarto` command-line parameter because they can not be
#' deparsed. This helper allows passing arbitrary expressions using the
#' `!expr` prefix, which is standardized by `yaml`.
#'
#' @note `r roxygen2_knitr_note()`
#'
#' @param opts A `list` of options. For any non-serializable values that would
#'   fail using your preferred interface to `knitr`, you may pass them as an
#'   expression string such as `"!expr mtcars"`. Notably,
#'   [`quarto::quarto_render`], which attempts to serialize objects for passing
#'   to the command-line `quarto`, will fail for such objects and requires the
#'   `"!expr"` prefix.
#' @param envir `environment` in which expressions should be evaluated.
#'
#' @return The `opts` list after parsing any complex expressions. This function
#'   is used primarily for modifying the global state by calling [`options()`]
#'
#' @examples
#' # in a knitr document, we'll imagine we have some `params` object that we
#' # want to use to set options:
#' params <- list(options = list(
#'   # most objects can be passed just fine
#'   example_1 = list(a = 1L, b = "two"),
#'
#'   # but objects that cannot be deserialized from their serialized (using,
#'   # for example [`dput()`], [`dump()`], and [`deparse()`]) expression would
#'   # fail as they are attempted to be passed to the `quarto` command-line
#'   # utility.
#'   complex_option = '!expr S7::new_class("example")()'
#' ))
#'
#' knitr_update_options(params$options)
#'
#' @export
knitr_update_options <- function(opts, envir = parent.frame()) {
  opts <- as.list(opts)
  opt_is_char <- vapply(opts, is.character, logical(1L))
  opt_is_expr <- opt_is_char
  opt_is_expr[opt_is_char] <- startsWith(
    as.character(opts[opt_is_char]),
    "!expr"
  )

  opts[opt_is_expr] <- lapply(
    opts[opt_is_expr],
    function(expr) eval(parse(text = sub("^!expr", "", expr)), envir = envir)
  )

  do.call(options, opts)
  opts
}


#' Create mutable header object
#'
#' Inject a custom document rendering hook into the knitr engine and return
#' a mutable environment that we can modify, which will be used to update the
#' knitr document header upon render completion.
#'
#' @note `r roxygen2_knitr_note()`
#'
#' @importFrom yaml yaml.load
#' @export
knitr_mutable_header <- function() {
  if (!requireNamespace("knitr", quietly = TRUE)) {
    warning("`knitr` is not available for use with knitr helpers")
    return()
  }

  header <- new.env(parent = emptyenv())

  # add a hook that will replace the hard-coded front-matter with dynamic
  # front-matter just before rendering.
  knitr::knit_hooks$set(
    document = local({
      default_document_hook <- knitr::knit_hooks$get("document")
      function(x, options) {
        # extract and split our document front-matter and body
        x <- paste(x, collapse = "\n")
        body <- sub("^\\s*(---|\\.\\.\\.).*?\\1", "", x, perl = TRUE)
        fm <- substring(x, 0L, nchar(x) - nchar(body))

        # pragmatically update front-matter at build-time
        fm <- yaml::yaml.load(fm)
        for (name in names(header)) {
          fm[[name]] <- header[[name]]
        }

        # rebuild our document
        x <- paste0(c("---", yaml::as.yaml(fm), "---", body), collapse = "\n")
        default_document_hook(x)
      }
    })
  )

  header
}

#' Special handler for emitting knitr logs
#'
#' @inheritParams knitr::knit_print
#'
#' @importFrom utils head tail capture.output
#' @export
# nolint start
knit_print.knitr_log <- local({
  # nolint end

  prefix <- "  \u205A " # vertical two dot punctuation
  last_log_trailing_newline <- FALSE

  # "progress" is used by knitr::knit function internally to store whether
  # progress should be written to console, equivalent to !quiet
  function(x, ...) {
    quiet <- !knitr::opts_knit$get("progress")
    if (quiet) {
      return()
    }

    # prefix newline only for the first message in each chunk
    knitr_log_env <- environment(knitr_logger)
    first_chunk_log <- knitr_log_env$first_chunk_log
    knitr_log_env$first_chunk_log <- FALSE

    # split content on non-character (or AsIs) objects
    is_char <- vapply(x, is.character, logical(1L))
    is_asis <- vapply(x, inherits, logical(1L), "AsIs")
    is_char <- is_char & !is_asis
    chunks <- cumsum(
      !is_char | c(FALSE, tail(is_char, -1) & !head(is_char, -1))
    )
    is_char_chunk <- vapply(split(is_char, chunks), any, logical(1L))

    # if output is a string, join them for pretty printing; otherwise capture
    # console output for logging
    x <- Map(
      function(chunk, is_char) {
        if (is_char) {
          paste(chunk, collapse = "")
        } else {
          paste(capture.output(chunk[[1L]]), collapse = "\n")
        }
      },
      chunk = split(x, chunks),
      is_char = is_char_chunk
    )

    # determine where to inject newline prefixes
    x <- paste0(x, collapse = "")
    x <- strsplit(x, "(?<=\n)", perl = TRUE)[[1L]]
    prefixed <- if (first_chunk_log || last_log_trailing_newline) TRUE else -1L
    x[prefixed] <- paste0(prefix, x[prefixed])
    x <- paste0(x, collapse = "")
    last_log_trailing_newline <<- endsWith(x[[length(x)]], "\n")

    # emit to stderr so that we see it immediately
    if (first_chunk_log) {
      cat("\n", file = stderr(), sep = "")
    }

    cat(x, file = stderr(), sep = "")
  }
})

#' Create a knitr log function
#'
#' Sets necessary knitr hooks and returns a logging function that will emit
#' messages to the console during knitting.
#'
#' @note `r roxygen2_knitr_note()`
#'
#' @return A `function` accepting `...` arguments, which will be used for
#'   printing out to the console while rendering the knitr document. Character
#'   values are logged directrly, while any other object is printed as though
#'   being printed to the console. To render character values as they would
#'   be printed, mark them as "AsIs" using [I()].
#'
#' @export
knitr_logger <- local({
  first_chunk_log <- TRUE

  function() {
    if (!requireNamespace("knitr", quietly = TRUE)) {
      warning("`knitr` is not available for use with knitr helpers")
      return()
    }

    # reset our chunk start flag on chunk output
    knitr::knit_hooks$set(
      chunk = local({
        default_chunk_hook <- knitr::knit_hooks$get("chunk")
        function(x, options) {
          first_chunk_log <<- TRUE
          default_chunk_hook(x, options)
        }
      })
    )

    function(...) {
      knitr::knit_print(structure(list(...), class = c("knitr_log", "list")))
    }
  }
})
