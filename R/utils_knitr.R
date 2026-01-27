#' Create mutable header object
#'
#' Inject a custom document rendering hook into the knitr engine and return
#' a mutable environment that we can modify, which will be used to update the
#' knitr document header upon render completion.
#'
#' @param params Optionally, provide default parameters to initialize with
#' @param envir Only used when `params` is not provided, as the source for where
#'   to try to discover the default knitr frontmatter parameters.
#'
#' @export
knitr_mutable_header <- function(params = NULL, envir = parent.frame()) {
  header <- new.env(parent = emptyenv())

  # if not provided, try to get params from envir
  if (is.null(params)) {
    params <- get0("params", envir = envir, ifnotfound = list())
  }

  # initialize with param values
  for (name in names(params)) {
    header[[name]] <- params[[name]]
  }

  # add a hook that will replace the hard-coded front-matter with dynamic
  # front-matter just before rendering.
  knitr::knit_hooks$set(
    document = local({
      default_document_hook <- knitr::knit_hooks$get("document")
      function(x, output) {
        # extract and split our document front-matter and body
        fm <- knitr:::yaml_front_matter(strsplit(x, "\n")[[1L]])
        body <- sub("^\\s*---.*---", "", x)

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
#' @export
# nolint start
knit_print.knitr_log <- local({
  # nolint end

  prefix <- "  \u205A " # vertical two dot punctuation
  last_log_trailing_newline <- FALSE

  function(x, ...) {
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
