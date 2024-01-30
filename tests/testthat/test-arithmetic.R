test_that("my_plus adds correctly", {
  expect_equal(my_plus(2, 2), 4, label = "plus_function_test_1")
})

test_that("my_minus subtracts correctly", {
    expect_equal(my_minus(2, 1), 1)
    expect_equal(my_minus(2, -1), 3)
})

test_that("my_division divides correctly" ,{
    expect_equal(my_division(2, 10), 0.2)
})

test_that("my_division warns when required", {
    expect_no_warning(my_division(10, 1))
    expect_no_warning(my_division(10, 0))
    expect_no_warning(my_division(10, 0, warn_Inf = FALSE))

    expect_warning(my_division(10, 0, warn_Inf = TRUE))
})

test_that("my_multiplication multiplies correctly", {
    expect_equal(my_multiplication(2, 3), 6)
})

test_that("my_multiplication fails when asked to for some reason", {
    expect_error(my_multiplication(2, 3, fail = TRUE), "Oh no!")
})
