#' Collect session information
#'
#' Catalogues characteristics of the R session and execution environment.
#'
#' @importFrom grDevices grSoftVersion
#' @importFrom utils sessionInfo
#' @export
session <- function() {
  # NOTE: data that is provided as named character vectors are coerced to
  # lists because the names otherwise get lost when passed as a quarto parameter

  list(
    time = Sys.time(),
    r_version = unclass(R.version),
    session_info = sessionInfo(),
    platform = .Platform,
    machine = .Machine,
    rng_kind = RNGkind(),
    capabilities = as.list(capabilities()),
    external_software = as.list(extSoftVersion()),
    graphics_software = as.list(grSoftVersion())
  )
}
