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

```{r, echo = FALSE}
library(val.report)

# logging
log <- knitr_logger()
log("test 1 2 3\n")

# update header
header <- knitr_mutable_header()
header$title <- "Mutable Title"

# update and save out options
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

    # this would work even without our function by just setting
    # `options(params$options)`. However, we want to make sure it still works
    # when it gets passed through our helper
    rmarkdown::render(example_qmd, params = params_r, quiet = TRUE)
    parsed_options <- example_parsed_options()

    expect_identical(parsed_options$example_2, example_2)
  }
)

test_that("knitr_update_options is still required for quarto::quarto_render", {
  skip_if_not_installed("quarto")
  skip_if(
    is.null(quarto::quarto_path()),
    "system `quarto` executable unavailable"
  )

  # ignore this test on cran because it is testing behavior of another package
  skip_on_cran()

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
    skip_if(
      is.null(quarto::quarto_path()),
      "system `quarto` executable unavailable"
    )

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

test_that("knitr_mutable_header can modify yaml frontmatter during runtime", {
  skip_if_not_installed("rmarkdown")

  rmarkdown::render(
    example_qmd,
    # pass content that will be used to modify the yaml frontmatter at runtime
    output_file = example_md <- tempfile(fileext = ".md"),
    output_format = rmarkdown::github_document(),
    quiet = TRUE
  )

  content <- readLines(example_md)
  expect_match(paste(content, collapse = "\n"), "^Mutable Title\n===", )
})

test_that("knitr_logger writes to console output", {
  skip_if_not_installed("rmarkdown")

  output <- capture.output({
    messages <- capture.output(type = "message", {
      rmarkdown::render(
        example_qmd,
        output_file = example_md <- tempfile(fileext = ".md"),
        output_format = rmarkdown::github_document()
      )
    })
  })

  expect_true(any(grepl("test 1 2 3", messages)))
})
