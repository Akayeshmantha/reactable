context("columns")

test_that("colDef", {
  # Default args
  expect_equal(colDef(), structure(list(Header = NULL, aggregate = NULL, Aggregated = NULL,
                              sortable = NULL, resizable = NULL, filterable = NULL,
                              show = TRUE), class = "colDef"))

  # Valid args
  col <- colDef(name = "col", aggregate = "sum",
                aggregated = JS("function(row) { return row.value }"),
                sortable = TRUE, resizable = TRUE, filterable = TRUE,
                show = TRUE)
  expected <- structure(list(Header = "col", aggregate = "sum",
    Aggregated = JS("function(row) { return row.value }"),
    sortable = TRUE, resizable = TRUE, filterable = TRUE,
    show = TRUE), class = "colDef")
  expect_equal(col, expected)

  # Invalid args
  invalidArgs <- list(
    name = list(1, FALSE),
    aggregate = list(2, TRUE, function() {}),
    aggregated = list(1, "row => row.value", TRUE, function(row) row$value),
    sortable = list(1, "TRUE"),
    resizable = list(1, "TRUE"),
    filterable = list(0, "FALSE"),
    show = list(0, "TRUE")
  )
  for (arg in names(invalidArgs)) {
    for (val in invalidArgs[[arg]]) {
      expect_error(do.call(colDef, setNames(list(val), arg)))
    }
  }
})

test_that("is.colDef", {
  expect_true(is.colDef(colDef()))
  expect_false(is.colDef(list()))
})