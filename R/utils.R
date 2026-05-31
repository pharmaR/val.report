`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

is_rds_path <- function(x) {
  is.character(x) && file.exists(x) && endsWith(x, ".Rds")
}

check_submodules_clone <- function() {
  report_dir <- system.file("report", package = "val.report")
  if (length(list.files(report_dir)) == 0L) {
    stop(paste0(
      packageName(),
      " `inst/report` directory is empty. \n",
      "It looks like you're using a development build that was installed ",
      "without cloned git submodules. If you cloned this repository from git, ",
      "make sure that you've cloned it using:\n\n",
      "    git clone --recurse-submodules ... \n\n",
      "or update an existing clone using:\n\n",
      "    git submodule update --init --recursive\n\n"
    ))
  }
}
