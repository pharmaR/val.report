#' Generates an R Validation Hub package report
#'
#' @examples
#' options(
#'   val.meter.logs = TRUE,
#'   val.meter.policy = val.meter::policy(permissions = TRUE)
#' )
#'
#' package_report(package = "path/to/package")
#'
#' @export
package_report <- function(
  package = NULL,
  session = NULL,
  options = val_options(plus = c("width")),
  template = system.file("report", "template.qmd", package = "val.report"),
  output_dir = getwd(),
  quiet = FALSE,
  ...
) {
  # temp dir for report output
  quarto_out_dir <- tempfile("val_report_")
  dir.create(quarto_out_dir)

  # temp dir for passing Rds content from subprocess to parent
  quarto_artifacts_dir <- tempfile("val_artifacts_")
  dir.create(quarto_artifacts_dir)

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
  rename_quarto_outputs(
    input_dir = quarto_out_dir,
    output_dir = output_dir,
    output_stem = report_stem
  )
}

rename_quarto_outputs <- function(input_dir, output_dir, output_stem) {
  files <- list.files(input_dir, full.names = TRUE)

  for (i in rev(seq_along(files))) {
    old_path <- files[[i]]
    new_path <- gsub("\\.", "-", output_stem)
    new_path <- paste0(new_path, ".", tools::file_ext(old_path))
    new_path <- file.path(output_dir, new_path)

    files[[i]] <- new_path
    file.copy(old_path, new_path, overwrite = TRUE)
    file.remove(old_path)
  }

  files
}

callr_val_package <- function(package, options, artifacts_dir, quiet) {
  library(S7)
  library(val.meter)

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

is_rds_path <- function(x) {
  is.character(x) && file.exists(x) && endsWith(x, ".Rds")
}

is_empty <- function(x) {
  is.null(x) || is.na(x) || !nzchar(x)
}
