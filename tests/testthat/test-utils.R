test_that("is_rds_path checks for existing Rds file", {
  f <- tempfile("test", fileext = ".Rds")
  expect_false(is_rds_path(f))
  write("test", f)
  expect_true(is_rds_path(f))
})
