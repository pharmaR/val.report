#' Generates an R Validation Hub package report
#'
#' @details
#' This function uses a pre-built `quarto` extension which provides its own
#' template document. To replace the existing template with your own without
#' further changes, ensure that your template exposes the same parameters.
#' Custom templates likely want to begin as a copy of the original report.
#'
#' @param package A package name, source code file path, url or path to an
#'   `Rds` file of a [val.meter::pkg] object . For details on accepted inputs,
#'   see [val.meter::pkg].
#' @param session A `list` of session information or a path to an `Rds` of a
#'   [val.report::session] object. If `NULL`, the session information will be
#'   derived when the package metrics are calculated. Will error if only one
#'   of `package` or `session` is provided as a `Rds` file.
#' @param options Additional options to use when deriving package metrics. By
#'   default, inherits any `val.*` options as well as a select few global
#'   environment variables.
#' @param template A `quarto` template file to use. See details for more
#'   information.
#' @param output_dir `character(1L)` directory path in which rendered files
#'   should be generated. Defaults to the current working directory.
#' @param quiet `logical(1L)` flag indicating whether output should be emitted
#'   to the console when rendering the report.
#' @param ... Additional arguments passed to [quarto::quarto_render()]
#'
#' @examples
#' \dontrun{
#' options(
#'   width = 80L,
#'   val.meter.logs = TRUE,
#'   val.meter.policy = val.meter::policy(permissions = TRUE)
#' )
#'
#' package_report(package = "path/to/package")
#' }
#'
#' @importFrom quarto quarto_version quarto_render
#' @importFrom callr r
#' @export
package_report <- function(
  package = NULL,
  session = NULL,
  options = val_options(plus = c("width")),
  template = NULL,
  output_dir = getwd(),
  quiet = FALSE,
  ...
) {
  # used for side effect of emitting errors when quarto is not available
  quarto::quarto_version()

  # temp dir for report output
  quarto_out_dir <- tempfile("val_report_")
  on.exit(unlink(quarto_out_dir, recursive = TRUE), add = TRUE)
  dir.create(quarto_out_dir)

  # temp dir for passing Rds content from subprocess to parent
  quarto_artifacts_dir <- tempfile("val_artifacts_")
  on.exit(unlink(quarto_artifacts_dir, recursive = TRUE), add = TRUE)
  dir.create(quarto_artifacts_dir)

  # if not provided, copy bundled template into temporary directory
  if (is.null(template)) {
    file.copy(
      system.file("report", package = "val.report"),
      tempdir(),
      recursive = TRUE
    )

    template_dir <- tempfile("val_report_template_")
    file.rename(file.path(tempdir(), "report"), template_dir)
    on.exit(unlink(template_dir, recursive = TRUE), add = TRUE)

    template <- file.path(template_dir, "template.qmd")
  }

  # derive metrics for package, write out to Rds
  if (is_rds_path(package) && !is_rds_path(session)) {
    stop("package provided as Rds file path, but session was not.")
  } else if (!is.null(session)) {
    stop("session provided, but package yet to be computed.")
  } else {
    callr_args <- list(
      package = package,
      options = options,
      artifacts_dir = quarto_artifacts_dir,
      quiet = quiet
    )

    res <- callr::r(
      callr_val_package,
      args = callr_args,
      show = TRUE,
      stderr = "2>&1"
    )

    package <- res$package
    session <- res$session
    options <- res$options # reset input options, no longer with Rds input
  }

  quarto::quarto_render(
    input = template,
    execute_dir = getwd(),
    execute_params = list(
      package = package,
      session = session,
      options = options
    ),
    quarto_args = c("--output-dir", quarto_out_dir),
    quiet = quiet %||% FALSE,
    ...
  )

  obj <- readRDS(package)
  report_stem <- paste0("val_", obj$name, "_", obj$version)
  copy_quarto_outputs(
    input_dir = quarto_out_dir,
    output_dir = output_dir,
    output_stem = report_stem
  )
}

#' @importFrom tools file_ext
copy_quarto_outputs <- function(input_dir, output_dir, output_stem) {
  files <- list.files(input_dir, full.names = TRUE)

  for (i in rev(seq_along(files))) {
    old_path <- files[[i]]
    if (dir.exists(old_path)) {
      files[[i]] <- NULL
      next
    }

    new_path <- gsub("\\.", "-", output_stem)
    new_path <- paste0(new_path, ".", tools::file_ext(old_path))
    new_path <- file.path(output_dir, new_path)

    files[[i]] <- new_path
    file.copy(old_path, new_path, overwrite = TRUE)
  }

  files
}

#' @importFrom S7 convert
#' @importFrom val.meter pkg metrics
callr_val_package <- function(package, options, artifacts_dir, quiet) {
  requireNamespace("S7")
  requireNamespace("val.meter")
  requireNamespace("val.report")

  # pass through configured options
  options(options)
  if (is.logical(quiet)) {
    options(val.meter.quiet = quiet)
  }

  # derive package metrics
  pkg <- S7::convert(package, val.meter::pkg)
  val.meter::metrics(pkg)

  # save out to Rds
  pkg_file <- paste0("val_", pkg$name, "_", pkg$version, "_")
  pkg_file <- gsub("\\.", "-", pkg_file)
  pkg_file <- file.path(artifacts_dir, paste0(pkg_file, ".Rds"))
  saveRDS(pkg, pkg_file)

  # record session info to Rds
  session_file <- file.path(artifacts_dir, "val_session.Rds")
  saveRDS(val.report::session(), session_file)

  list(package = pkg_file, session = session_file, options = list())
}

val_options <- function(prefix = "val.", plus = character(0L)) {
  opts <- options()
  append(opts[startsWith(names(opts), prefix)], opts[plus])
}
