#' Test de Normalidad de Anderson-Darling
#'
#' @description
#' **Configuración previa de Inteligencia Artificial (Gemini):**
#'
#' Para utilizar las capacidades de IA integradas, sigue estos pasos de configuración inicial:
#'
#' 1. **Instalar dependencias:**
#'    ```r
#'    install.packages("ellmer")
#'    install.packages("usethis")
#'    ```
#' 2. **Cargar librerías:**
#'    ```r
#'    library(ellmer)
#'    library(usethis)
#'    ```
#' 3. **Configurar tu API Key:**
#'    Ejecuta el siguiente comando para abrir el archivo de configuración de tu entorno:
#'    ```r
#'    usethis::edit_r_environ()
#'    ```
#'    En la ventana que se abre, pega tu clave en una línea nueva de esta forma:
#'    `GOOGLE_API_KEY="tu-api"`
#'    Luego, guarda el archivo, **cierra por completo y vuelve a abrir RStudio** para aplicar los cambios.
#'
#' 4. **Verificar conexión y uso:**
#'    Correr esto para verificar que ya se conecto, deberia aparecer tu api:
#'    ```r
#'    Sys.getenv("GOOGLE_API_KEY")
#'    data2 <- chat_google_gemini()
#'    ```
#'    Esto se usa como: `data2$chat("aqui-escribes-pregunta")`
#'
#' ---
#'
#' **Documentación Técnica del Test (Anderson-Darling Normality Test):**
#'
#' **Usage** #' ad.test(x)
#'
#' **Arguments** #' `x`: a numeric vector of data values, the number of which must be greater than 7. Missing values are allowed.
#'
#' **Value** #' A list with class htest containing the following components:
#' * `statistic`: the value of the Anderson-Darling statistic.
#' * `p.value`: the p-value for the test.
#' * `method`: the character string Anderson-Darling normality test.
#' * `data.name`: a character string giving the name(s) of the data.
#'
#' **Details** #' The Anderson-Darling test is an EDF omnibus test for the composite hypothesis of normality. The test statistic is:
#'
#' \mjsdeqn{A^2 = -n - \frac{1}{n} \sum_{i=1}^{n} (2i - 1) \left[ \ln(p_{(i)}) + \ln(1 - p_{(n-i+1)}) \right]}
#'
#' where \mjseqn{p_{(i)} = \Phi([x_{(i)} - \overline{x}]/s)}. Here, \mjseqn{\Phi} is the cumulative distribution function of the standard normal distribution, and \mjseqn{\overline{x}} and \mjseqn{s} are mean and standard deviation of the data values. The p-value is computed from the modified statistic \mjseqn{Z=A^2 (1.0 + 0.75/n +2.25/n^{2})} according to Table 4.9 in Stephens (1986).
#'
#' **References** #' * Stephens, M.A. (1986): Tests based on EDF statistics. In: D'Agostino, R.B. and Stephens, M.A., eds.: Goodness-of-Fit Techniques. Marcel Dekker, New York.
#' * Thode Jr., H.C. (2002): Testing for Normality. Marcel Dekker, New York.
#'
#' **See Also** #' `shapiro.test` for performing the Shapiro-Wilk test for normality. `cvm.test`, `lillie.test`, `pearson.test`, `sf.test` for performing further tests for normality. `qqnorm` for producing a normal quantile-quantile plot.
#'
#' @param x Un vector numérico.
#' @export
ad.testeo <- function(x) {
  # Aquí puedes colocar tu propio código o dejarlo en blanco por ahora
}
