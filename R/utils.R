mergeLists <- function(a, b) {
  for (name in names(b)) {
    a[[name]] <- b[[name]]
  }
  a
}