#' Hello
#'
#' @param who Who to say hello to
#' @returns A character value with a greeting
#'
#' @export
hello <- function(who = "world") {
  paste0("Hello, ", who, "!")
}
