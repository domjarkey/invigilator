connect_to_server <- function(username, password) {
    tries <- 0

    while (tries < 3) {
        con <- try_to_connect(username, password)

        if (con$connected) {
            break
        } else {
            message("retrying...")
            tries <- tries + 1
        }
    }

    if (con$connected == FALSE) {
        stop("I failed to connect")
    }

    con
}

try_to_connect <- function(username, password) {
    stop("I don't actually work")
}

query_database <- function(connection, query) {
    stop("I don't work either!")
}

download_my_important_data <- function() {
    con <- connect_to_server("my_username", "my_password")

    res <- query_database(con, "who are all the naughty panelists?")

    if (is.null(res)) {
        stop("Null response from server")
    }

    if (nrow(res) == 0) {
        warning("No new naughty panelists")
    }

    res
}
