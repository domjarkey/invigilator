# invigilator

This package provides a minimal example of unit testing in R using the [`testthat`](https://testthat.r-lib.org/) framework.  The exported functions themselves are simple; the goal is to showcase different expectations and mocking techniques in tests.

## Tests

### Arithmetic helpers

`tests/testthat/test-arithmetic.R` exercises basic math functions while demonstrating several expectations:

- `expect_equal()` checks addition, subtraction, division and multiplication results.
- `expect_warning()` and `expect_no_warning()` verify how division handles zero denominators.
- `expect_error()` shows how a failing multiplication can be asserted.

### Comparing objects and return types

`tests/testthat/test-misc.R` illustrates comparisons and structural checks:

- Floating point equality and identity comparisons, including tolerance handling.
- Comparing base data frames with tibbles while ignoring attributes.
- Validating the type, length and names of the range returned by `my_range()`.

### Mocking server requests

`tests/testthat/test-server_requests.R` uses the `mockery` package to replace network calls:

- `mockery::stub()` and `with_mocked_bindings()` inject stand‑in functions for `connect_to_server`, `try_to_connect`, and `query_database`.
- Expectations assert successful downloads, warnings on empty results, retry messages, and errors after repeated failures.

## Running the tests

From the package root run:

```r
R -q -e "devtools::test()"
```

or with `testthat` directly:

```r
Rscript -e 'testthat::test_dir("tests/testthat")'
```

---

This repository is intended purely as a learning aid for unit testing; the functions are intentionally simplistic.
