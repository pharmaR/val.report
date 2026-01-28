example_1 <- list(a = 8L, b = "bee")
example_2 <- S7::new_class("test", package = "example")()
example_2_yaml_expr <- '!expr S7::new_class("test", package = "example")()'

params_r <- list(
  options = list(
    example_1 = example_1,
    example_2 = example_2
  )
)

params_expr <- list(
  options = list(
    example_1 = example_1,
    example_2 = example_2_yaml_expr
  )
)

example_qmd <- tempfile(fileext = ".qmd")
example_rds <- tempfile(fileext = ".Rds")
example_parsed_options <- function() readRDS(example_rds)

writeLines(
  con = example_qmd,
  sprintf(
    '
---
title: Example
params: { options: NULL }
---
```{r}
library(val.report)
opts <- knitr_update_options(params$options)
saveRDS(opts, "%s")
```',
    example_rds
  )
)

test_that("knitr_update_options can accept complex R objects", {
  opts <- options()
  on.exit(options(opts))

  expect_silent(knitr_update_options(params_r$options))
  expect_identical(getOption("example_1"), example_1)
  expect_identical(getOption("example_2"), example_2)
})

test_that(
  paste(
    "knitr_update_options accepts complex R objects through",
    "rmarkdown::render"
  ),
  {
    skip_if_not_installed("rmarkdown")

    opts <- options()
    on.exit(options(opts))

    # this would work even without our function by just setting
    # `options(params$options)`. However, we want to make sure it still works
    # when it gets passed through our helper
    rmarkdown::render(example_qmd, params = params_r)
    parsed_options <- example_parsed_options()

    expect_identical(parsed_options$example_2, example_2)
  }
)

test_that("knitr_update_options is still required for quarto::quarto_render", {
  skip_if_not_installed("quarto")
  skip_if(is.null(quarto::quarto_path()))

  # ignore this test on cran because it is testing behavior of another package
  skip_on_cran()

  opts <- options()
  on.exit(options(opts))

  # if this test starts to fail, it probably means that S7 has found a solution
  # to serializing their objects, removing the need for `knitr_update_options`
  #
  # See:
  #   - https://github.com/RConsortium/S7/issues/225
  #   - https://github.com/RConsortium/S7/issues/524
  #
  quarto::quarto_render(example_qmd, execute_params = params_r) |>
    expect_error("not implemented.*'object'") |>
    expect_warning("'object'")
})

test_that(
  paste(
    "knitr_update_options accepts complex R objects through",
    "quarto::quarto_render"
  ),
  {
    skip_if_not_installed("quarto")
    skip_if(is.null(quarto::quarto_path()))

    opts <- options()
    on.exit(options(opts))

    quarto::quarto_render(
      example_qmd,
      execute_params = params_expr,
      quiet = TRUE
    ) |>
      expect_silent()

    parsed_options <- example_parsed_options()
    expect_identical(parsed_options$example_2, example_2)
  }
)
