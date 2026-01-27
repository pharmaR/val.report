#' Reports about a package
#'
#' @param package_name Package name.
#' @param package_version Package version number.
#' @param package Path where to find a package source to retrieve name and version number.
#' @param template_path Path to a directory with one quarto template file (and the files required for rendering it).
#' @param output_format Output format for the report. Default is "all".
#' @param params A list of execute parameters passed to the template
#' @param ... Additional arguments passed to `quarto::quarto_render()`
#'
#' @return A path to the reports generated, called by its side effects.
#' @details Please include source as part of `params` content. Source is returned after
#' calling function `riskmetric::pkg_ref` before the risk assessment is executed
#' @export
#' @examples
#' options("valreport_output_dir" = tempdir())
#' pr <- package_report(
#'   package_name = "dplyr",
#'   package_version = "1.1.4",
#'   params = list(
#'     assessment_path = system.file("assessments/dplyr.rds", package = "val.report"),
#'     image = "rhub/ref-image"),
#'     quiet = FALSE
#' )
#' pr
#' file.remove(pr)
package_report <- function(
    package_name,
    package_version,
    package = NULL,
    template_path = system.file("report/package", package = "val.report"),
    output_format = "all",
    params = list(),
    ...
) {
    empty_pkg_info <- is.empty(package_name) && is.empty(package_version)
    if (empty_pkg_info && !is.empty(package)) {
      package_name <- basename(package)
      desc <- read.dcf(file.path(package, "DESCRIPTION"))

      stopifnot("Mismatch between path and DESCRIPTION name" = package_name == desc[, "Package"])
      package_version <- desc[, "Version"]
      params$package <- package
      Sys.setenv("INPUT_REPORT_PKG_DIR" = package)
    } else if (empty_pkg_info && is.empty(package)) {
      stop("Package information missing for the report")
    } else {
      params$package <- package_name
    }

    full_name <- paste0(package_name, "_v", package_version)
    output_file <- paste0("validation_report_", full_name, ".qmd")

    params$package_name <- package_name
    params$package_version <- package_version
    params$image <- get_image_name(params)

    if (is.null(template_path) || !nzchar(template_path)) {
        template_path <- system.file("report/package",
                                     package = "val.report")
    } else if (!dir.exists(template_path)) {
        stop("Template directory is not available")
    }

    params$package <- normalizePath(params$package, mustWork = FALSE, winslash = "/")
    if (length(params$assessment_path) == 1L && !nzchar(params$assessment_path)) {
      params$assessment_path <- normalizePath(params$assessment_path, mustWork = TRUE, winslash = "/")
    }

    # Bug on https://github.com/quarto-dev/quarto-cli/issues/5765
    v <- quarto::quarto_version()
    if (v < package_version("1.7.13")) {
      warning("Please install the latest version of Quarto")
    }

    if (is.null(params$source)) warning("Please provide the source of the package assessment")

    # https://github.com/quarto-dev/quarto-r/issues/81#issuecomment-1375691267
    # quarto rendering happens in the same place as the file/project
    # To avoid issues copy to a different place and render there.
    render_dir <- output_dir()
    if (!dir.exists(render_dir)) {
      render_dir <- paste0(render_dir, "/")
      if (!dir.exists(render_dir)) {
        stop("Render directory doesn't exists. Please check the 'getOptions(\"valreport_output_dir\")' and sys.getEnv(\"VALREPORT_OUTPUT_DIR\")" )
      }
    }
    files_to_copy <- list.files(template_path, full.names = TRUE)
    fc <- file.copy(from = files_to_copy,
                    to = render_dir,
                    overwrite = TRUE,
                    copy.date = TRUE)

    if (any(!fc)) {
      stop("Copying to the rendering directory failed.")
    }

    template_all_files <- list.files(render_dir, full.names = TRUE)
    template <- template_all_files[endsWith(template_all_files, "qmd")]

    if (length(template) > 1) {
      stop("There are more than one template!\n",
           "Please have only one quarto file on the directory.")
    }

    file_template <- file.path(render_dir,
                               paste0("validation_report_", full_name, ".qmd"))
    file.rename(template, file_template)

    # replace the title of the place header by the package name and header
    top_page_file <- readLines(file.path(render_dir, "top_page.html"))
    title_line <- grep("<p", top_page_file)
    top_page_file[title_line] <- htmltools::p(paste0("Validation Report - ", package_name, "@", package_version)) |>
      as.character()
    writeLines(top_page_file, file.path(render_dir, "top_page.html"))

    pre_rendering <- list.files(render_dir, full.names = TRUE)

    suppressMessages({suppressWarnings({
      out <- quarto::quarto_render(
        input = file_template,
        output_format = output_format,
        execute_params = params,
        ...
      )
    })})

    post_rendering <- list.files(render_dir, full.names = TRUE)

    files_to_remove <- intersect(pre_rendering, post_rendering)
    fr <- file.remove(files_to_remove)
    if (any(!fr)) {
      warning("Failed to remove the quarto template used from the directory.")
    }

    output_files <- setdiff(post_rendering, pre_rendering)
    invisible(output_files)
}

is.empty <- function(x) {
  is.null(x) || is.na(x) || !nzchar(x)
}
