test_that("download_my_important_data mock runs", {
  mockery::stub(
      where = download_my_important_data,
      what = "connect_to_server",
      how = function(username, password) {
          TRUE
      }
  )

    mockery::stub(
        where = download_my_important_data,
        what = "query_database",
        how = function(username, password) {
            data.frame(x = 1:3)
        }
    )

    res <- download_my_important_data()

    expect_equal(res, data.frame(x = 1:3))
})

test_that("download_my_important_data mock warns and fails when expected", {
    ## Warn on nrow == 0
    mockery::stub(
        where = download_my_important_data,
        what = "connect_to_server",
        how = function(username, password) {
            TRUE
        }
    )

    mockery::stub(
        where = download_my_important_data,
        what = "query_database",
        how = function(username, password) {
            data.frame(x = integer(0))
        }
    )

    expect_warning(
        res <- download_my_important_data(),
        "No new naughty panelists"
    )

    expect_equal(res, data.frame(x = integer(0)))
})

test_that("connect_to_server works on first try (mock + stub)", {
    ## Succeed on first try
    mock_try_to_connect <- mockery::mock(
        list(connected = TRUE)
    )

    mockery::stub(connect_to_server, "try_to_connect", mock_try_to_connect)

    con <- connect_to_server("username", "password")

    expect_true(con$connected)
    mockery::expect_called(mock_try_to_connect, 1)
})

test_that("connect_to_server retries up to 3 times", {
    ## Succeed on first try
    mock_try_to_connect <- mockery::mock(
        list(connected = TRUE)
    )

    with_mocked_bindings(
        con <- connect_to_server("username", "password"),
        try_to_connect = mock_try_to_connect
    )

    expect_true(con$connected)
    mockery::expect_called(mock_try_to_connect, 1)

    ## Succeed on second try
    mock_try_to_connect <- mockery::mock(
        list(connected = FALSE),
        list(connected = TRUE)
    )

    expect_message(
        with_mocked_bindings(
            con <- connect_to_server("username", "password"),
            try_to_connect = mock_try_to_connect
        ),
        "retrying..."
    )

    expect_true(con$connected)
    mockery::expect_called(mock_try_to_connect, 2)

    ## Error after three fails
    mock_try_to_connect <- mockery::mock(
        list(connected = FALSE),
        list(connected = FALSE),
        list(connected = FALSE),
        list(connected = TRUE)
    )

    expect_error(
        with_mocked_bindings(
            con <- connect_to_server("username", "password"),
            try_to_connect = mock_try_to_connect
        ),
        "I failed to connect"
    )
    mockery::expect_called(mock_try_to_connect, 3)
})
