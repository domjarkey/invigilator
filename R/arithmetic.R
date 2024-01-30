my_plus <- function(x, y) {
    x + y
}

my_minus <- function(x, y) {
    x - y
}

my_division <- function(x, y, warn_Inf = FALSE) {
    if (warn_Inf && y == 0) {
        warning("Result will be infinite or NaN")
    }
    x / y
}

my_multiplication <- function(x, y, fail = FALSE) {
    if (fail) {
        stop("Oh no!")
    }
    x * y
}

my_range <- function(x) {
    c(min = min(x), max = max(x))
}
