describe("Run test for the report", {
  it("should be generated in all formats", {
    skip_if(is.null(quarto::quarto_path()))

    output_dir <- tempfile()
    dir.create(output_dir)
    on.exit(unlink(output_dir, recursive = TRUE))

    options(
      val.meter.logs = TRUE,
      val.meter.policy = val.meter::policy(permissions = TRUE)
    )

    expect_no_error(
      package_report(
        package = testthat::test_path("fixtures", "test.pkg"),
        quiet = TRUE,
        output_dir = output_dir
      )
    )

    expect_length(list.files(output_dir, pattern = "\\.html$"), 1L)
    expect_length(list.files(output_dir, pattern = "\\.pdf$"), 1L)
  })
})
