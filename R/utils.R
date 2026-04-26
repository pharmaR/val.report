`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

is_rds_path <- function(x) {
  is.character(x) && file.exists(x) && endsWith(x, ".Rds")
}
