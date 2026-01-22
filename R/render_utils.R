#' analyze license output from risk assessment to display in cards
#'
#' @param assessment object returning from riskmetric assessment, it can also be data.frame from val.report::assessment
#' @return list with main card license string and footer if available
#' @details The function analyzes if the license is standard. If it is standard, then it will see if there is available
#' information for the footer. The footer information is only the multiple version number for the moment.
#' @keywords internal
#' @importFrom utils getFromNamespace
extract_license <- function(assessment) {
  license_output <- list(main = as.character(assessment$license))
  # We use the internal version so that we can use old R versions analyze_license
  if (getRversion() < "4.4.0") {
    analyze_license <- utils::getFromNamespace("tools", "analyze_license") # nolint
  } else {
    analyze_license <- tools::analyze_license
  }
  license_analysis <- analyze_license(license_output$main)

  if (isTRUE(license_analysis$is_standardizable)) {
    license_output$main <- sub("\\(.+\\)", "", license_analysis$components[1])
    if (grepl("\\(.+\\)",license_analysis$components[1])) {
    license_output$footer <- sub("^.+\\((.+)\\)", "\\1", license_analysis$components[1])
    }

    if (length(license_analysis$components) > 1) {
      license_output$footer <- paste(
        c(license_output$footer,
          license_analysis$components[seq(2, length(license_analysis$components))])
        , collapse = "|")
    }
  }
  license_output
}

#' Create a info card for the report
#'
#' @importFrom htmltools div
#' @param title text to include in the card title
#' @param header text or html content to be included in the card header
#' @param text content to be included as class card text
#' @param extra_class whether to add additional class for the card div in order to modify style
#' @details check https://getbootstrap.com/docs/5.0/components/card/ for class names and card content
#' To style the card, assign a custom class and style the card within the quarto theme
#' @keywords internal
create_info_card <- function(title, header = NULL, text = NULL, extra_class = NULL) {
  header_div <- if (!is.null(header)) div(header, class = "card-header") else header
  text_div <- if (!is.null(text)) div(text, class = "card-text") else text
  div(
    class = paste("card", extra_class),
    header_div,
    htmltools::h3(title, class = "card-title"),
    text_div
    )
}

create_metrics_cards <- function(assessment_info) {
  license_card_values <- extract_license(assessment_info)
  div(
    class = "info-card",
      div(
        class = "top-card",
          create_info_card(
            title = assessment_info$downloads_1yr,
            # check for icon shapes here: https://icons.getbootstrap.com/
            header = htmltools::tagList(htmltools::tags$i(class = "bi bi-download"), htmltools::p("1 year")),
            text = "Downloads",
            extra_class = "top-left-card"
          ),
        div(
          class = "top-right-card",
          create_info_card(title = assessment_info$reverse_dependencies, header = "Reverse Dependencies", extra_class = "left-card"),
          create_info_card(title = license_card_values$main, header = "License", text = license_card_values$footer, extra_class = "right-card")
        )
      ),
      create_info_card(title = assessment_info$origin, header = "Origin", extra_class = "bottom-card")
  )
}

#' Return the Docker Image name to be printed on the report
#'
#' @keywords internal
get_image_name <- function(params) {
  default_image <- "rhub/ref-image"
  image <- Sys.getenv("DOCKER_IMAGE", unset = NA)

  if (is_empty(image) && !is_empty(params$image)) {
    image <- params$image
  } else if (is_empty(image)) image <- default_image
  image
}

#' Handler for complex option passing through from a quarto parameter
#'
#' Importantly, handles S7 objects which cannot be passed through as a quarto
#' parameter because they can not be deparsed. Allows passing arbitrary
#' expressions using the `!expr` prefix used by `yaml`.
#'
#' @export
knitr_update_options <- function(opts) {
  opts <- as.list(opts)
  opt_is_char <- vapply(opts, is.character, logical(1L))
  opt_is_expr <- opt_is_char
  opt_is_expr[opt_is_char] <- startsWith(as.character(opts[opt_is_char]), "!expr")
  opts[opt_is_expr] <- lapply(
    opts[opt_is_expr],
    function(expr) eval(parse(text = sub("^!expr", "", expr)))
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
#' @export
knitr_mutable_header <- function() {
  header <- new.env(parent = emptyenv())

  knitr::knit_hooks$set(document = local({
    default_document_hook <- knitr::knit_hooks$get("document")
    function(x, output) {
      # extract and split our document front-matter and body
      fm <- knitr:::yaml_front_matter(strsplit(x, "\n")[[1L]])
      body <- sub("\\s*---.*---", "", x)

      # pragmatically update front-matter at build-time
      fm <- yaml::yaml.load(fm)
      for (name in names(header)) {
        fm[[name]] <- header[[name]]
      }

      # rebuild our document
      x <- paste0(c("---", yaml::as.yaml(fm), "---", body), collapse = "\n")
      default_document_hook(x)
    }
  }))

  header
}

#' Special handler for emitting knitr logs
#'
#' @export
knit_print.knitr_log <- local({
  prefix <- "  \u205A "  # vertical two dot punctuation
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
    chunks <- cumsum(!is_char | c(FALSE, tail(is_char, -1) & !head(is_char, -1)))
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
    if (first_chunk_log) cat("\n", file = stderr(), sep = "")
    cat(x, file = stderr(), sep = "")
  }
})

#' Create a knitr log function
#'
#' Sets necessary knitr hooks and returns a logging function that will emit
#' messages to the console during knitting.
#'
#' @export
knitr_logger <- local({
  first_chunk_log <- TRUE

  function() {
    # reset our chunk start flag on chunk output
    knitr::knit_hooks$set(chunk = local({
      default_chunk_hook <- knitr::knit_hooks$get("chunk")
      function(x, options) {
        first_chunk_log <<- TRUE
        default_chunk_hook(x, options)
      }
    }))

    function(...) {
      knitr::knit_print(structure(list(...), class = c("knitr_log", "list")))
    }
  }
})
