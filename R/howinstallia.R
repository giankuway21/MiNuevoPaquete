#' Test de Normalidad de Anderson-Darling
#'
#' @description
#' **Configuración:** Instala `ellmer` y `usethis` con `install.packages()`, cárgalas con `library()`, corre `usethis::edit_r_environ()` para pegar tu token como `GOOGLE_API_KEY="tu-api"`, reinicia RStudio, verifica con `Sys.getenv("GOOGLE_API_KEY")`, inicializa con `data2 <- chat_google_gemini()` y genera consultas usando `data2$chat("pregunta")`. Tambien corre esto para conseguir tu api "ap(id="A")" la A es for you, las otras letras son las mias. Te botara un codigo, quitale el QUIT_A del inicio y los #, con eso tienes el codigo y asi podras usarlo.
#'
#' @section Usage:
#' ad.testeo(x)
#'
#' @section Arguments:
#' \+ **x**: a numeric vector of data values, the number of which must be greater than 7. Missing values are allowed.
#'
#' @section Value:
#' A list with class `htest` containing the following components:
#' \+ **statistic**: the value of the Anderson-Darling statistic.
#' \+ **p.value**: the p-value for the test.
#' \+ **method**: the character string "Anderson-Darling normality test".
#' \+ **data.name**: a character string giving the name(s) of the data.
#'
#' @section Details:
#' The Anderson-Darling test is an EDF omnibus test for the composite hypothesis of normality.
#' The test statistic is:
#'
#' \deqn{A^2 = -n - \frac{1}{n} \sum_{i=1}^{n} (2i - 1) [ \ln(p_{(i)}) + \ln(1 - p_{(n-i+1)}) ]}
#'
#' where \eqn{p_{(i)} = \Phi([x_{(i)} - \bar{x}]/s)}. Here, \eqn{\Phi} is the cumulative distribution function of the standard normal distribution, and \eqn{\bar{x}} and \eqn{s} are mean and standard deviation of the data values. The p-value is computed from the modified statistic \eqn{Z = A^2 (1.0 + 0.75/n + 2.25/n^2)} according to Table 4.9 in Stephens (1986).
#'
#' @references
#' * Stephens, M.A. (1986): Tests based on EDF statistics. In: D'Agostino, R.B. and Stephens, M.A., eds.: *Goodness-of-Fit Techniques*. Marcel Dekker, New York.
#' * Thode Jr., H.C. (2002): *Testing for Normality*. Marcel Dekker, New York.
#'
#' @seealso
#' `shapiro.test` for performing the Shapiro-Wilk test for normality. `cvm.test`, `lillie.test`, `pearson.test`, `sf.test` for performing further tests for normality. `qqnorm` for producing a normal quantile-quantile plot.
#'
#' @param x Un vector numérico.
#' @export
ad.testeo <- function(x) {
  # Contenedor de la documentación
}
