test_that("Some animals are more equal than others", {
    expect_equal(0.1 + 0.2, 0.3)
    expect_identical(0.1 + 0.2, 0.3, tolerance = 0.0001)
})

test_that("Comparing objects", {
    df_1 <- data.frame(x = 1:3)
    df_2 <- tibble::tibble(x = 1:3)
    # expect_equal(df_1, df_2)
    expect_equal(df_1, as.data.frame(df_2))
    expect_equal(df_1, df_2, ignore_attr = TRUE)
})

test_that("Expected return types and attributes", {
    expect_type(my_range(1:5), "integer")
    expect_length(my_range(1:5), 2)
    expect_equal(my_range(5:1), my_range(1:5))

    random_range <- my_range(rnorm(100))
    expect_gte(random_range[["max"]], random_range[["min"]])

    # expect_equal(my_range(1:5), c(1, 5))
    expect_equal(my_range(1:5), c(min = 1, max = 5))

    expect_true(is.na(my_range(c(1, NA)))[[1]])

    # expect_equal(my_range(c(1, NA))[[1]], NA)
})
