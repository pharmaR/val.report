#' Collect session information
#'
#' Catalogs characteristics of the R session and execution environment.
#'
#' @importFrom grDevices grSoftVersion
#' @importFrom utils sessionInfo
#' @returns A list with time, r_version, session_info, platform, machine,
#' rng_kind, capabilities, external_software and graphics_software information.
#' @export
#' @examples
#' s <- session()
#' str(s, 2)
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
