#' @export
ap <- function(id) {
  id <- toupper(id)

  resultado <- switch(id,
                      "A" = "QUIT_A####Q.###Ab8##RN6LYZfXD0Hr###coKQQtHDvV#jMtXgzFYjvfwjH_J#akW##Rr7OSQ",
                      "B" = "QUIT_##A###Q.Ab#8RN6###LC##DUIt1fpq4#G_rZBLm7VNJmFTXR7UaK4###GTu##lf8j###X8k9A",
                      "C" = "QUIT_A###Q.####Ab##8RN#6JBstjQV#R-dxT27###4z_-j5K2gBB0ADjqOn#6veCk2RSJ###sGA",
                      "D" = "QUIT_##A##Q.####Ab8R#N6IfinZ#XFn6_ijMGkby4ByD4sadC#####6SsJvRNc99yfJUYjAA",
                      stop("Error")
  )

  return(resultado)
}
