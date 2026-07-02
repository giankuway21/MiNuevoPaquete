#' Script Completo de Estadística No Paramétrica (EP4146)
#'
#' @description
#' base64encode encodes a data into base64 encoding. The source can be a file, binary connection or a raw vector.base64decode decodes a base64-encoded string into binary data. The source can be a string or a connection, the output is either a raw vector (output=NULL) or a binary connection.
#'
#' BLOQUE 1: K INDEPENDIENTES
#'
#' 01. Anderson-Darling (Forma)
#' library(kSamples)
#' g1 <- c(12,15,14,13,16); g2 <- c(20,22,19,21,23); g3 <- c(30,28,31,29,32)
#' y <- c(g1, g2, g3); g <- factor(rep(c("G1","G2","G3"), each=5))
#' y_cor <- c(g1 - median(g1), g2 - median(g2), g3 - median(g3))
#' Hip -> H0: F(G1) = F(G2) = F(G3) vs H1: Al menos un F(Gi) es diferente
#' ad.test(y_cor ~ g, method = "asymptotic")
#' pnorm(T.AD, lower.tail = FALSE) # P-valor manual
#' Alerta: Si medianas distintas -> corregir por mediana. Si T.AD es negativo -> p-valor cercano a 1.
#'
#' 02. Prueba de la Mediana (Posición)
#' library(agricolae)
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' Median.test(y = y, trt = g, alpha = 0.05, group = FALSE, correct = TRUE, console = TRUE)
#' pchisq(chi2_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' library(BSDA); SIGN.test(g1, conf.level = 0.95) # IC para la mediana
#' Alerta: No exige igual forma -> única aplicable cuando AD rechaza H0.
#'
#' 03. Kruskal-Wallis (Posición)
#' library(agricolae)
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' kruskal(y = y, trt = g, alpha = 0.05, group = FALSE, console = TRUE) # Con p-valores por par
#' kruskal(y = y, trt = g, alpha = 0.05, group = TRUE, console = TRUE) # Con letras de agrupamiento
#' pchisq(H_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Alerta: Exige igual forma -> requiere AD previo. Usar datos originales, no corregidos.
#'
#' 04. Van der Waerden (Posición)
#' library(agricolae)
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' waerden.test(y = y, trt = g, alpha = 0.05, group = FALSE, console = TRUE)
#' pchisq(T1_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Alerta: Exige igual forma -> requiere AD previo. Output reporta promedios de puntuaciones normales, NO medias.
#'
#' 05. Jonckheere-Terpstra (Tendencia)
#' library(clinfun)
#' g <- factor(rep(c("G1","G2","G3"), each=5), levels = c("G1","G2","G3"))
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Me1 <= Me2 <= Me3 (al menos una estricta)
#' jonckheere.test(x = y, g = as.numeric(g), alternative = "increasing") # Creciente
#' jonckheere.test(x = y, g = as.numeric(g), alternative = "decreasing") # Decreciente
#' Estandarización manual:
#' n <- length(y); ni <- rep(5, 3); mu <- (n^2 - sum(ni^2)) / 4
#' sg <- sqrt((n^2*(2*n+3) - sum(ni^2*(2*ni+3))) / 72); Z <- (JT_calc - mu) / sg
#' pnorm(Z, lower.tail = FALSE)
#' Alerta: H0 siempre es igualdad. No requiere AD previo. El orden de los levels debe coincidir con la tendencia.
#'
#' 06. Levene (Escala)
#' library(lawstat)
#' Hip -> H0: var1 = var2 = var3 vs H1: Al menos una varianza es diferente
#' levene.test(y, g)
#' pf(W_calc, df1 = 2, df2 = 12, lower.tail = FALSE) # P-valor manual
#' Nota: Clave "desviaciones absolutas respecto a la mediana/media". Estadístico W ~ F(k-1, n-k).
#'
#' 07. Fligner-Killeen (Escala)
#' # Hip -> H0: var1 = var2 = var3 vs H1: Al menos una varianza es diferente
#' fligner.test(y, g) # Base R - sin instalación
#' pchisq(FK_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' # Nota: Clave "función de puntuación" + medianas distintas/asimétricas. NO exige igualdad de medianas.
#'
#' 08. Klotz (Escala)
#' library(coin)
#' Hip -> H0: var1 = var2 = var3 vs H1: Al menos una varianza es diferente
#' klotz_test(y ~ g)
#' pchisq(K_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Alerta: Clave "función de puntuación" + medianas iguales/simétricas. SÍ exige igualdad de medianas.
#'
#' 09. Conover (Escala)
#' library(coin)
#' Hip -> H0: var1 = var2 = var3 vs H1: Al menos una varianza es diferente
#' conover_test(y ~ g, distribution = "asymptotic")
#' pchisq(C_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Nota: Clave "según Conover" o "rangos al cuadrado". Sí hace comparaciones múltiples por pares.
#'
#' BLOQUE 2: K RELACIONADAS
#'
#' 10. Q de Cochran (Dicotómica)
#' library(RVAideMemoire)
#' res <- c(0,1,1, 0,1,0, 1,1,1, 0,0,1, 1,1,1, 0,1,1)
#' tra <- factor(rep(c("T1","T2","T3"), times=6)); blo <- factor(rep(1:6, each=3))
#' Hip -> H0: p1 = p2 = p3 vs H1: Al menos una p_i es diferente
#' cochran.qtest(res ~ tra | blo)
#' pchisq(Q_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Nota: Solo para variable dicotómica (0/1). Extensión de McNemar para k relacionadas.
#'
#' 11. Friedman (Posición)
#' library(agricolae)
#' res <- c(3.2,4.1,5.0, 2.8,3.9,4.7, 3.5,4.4,5.3, 2.6,3.6,4.4, 3.8,4.7,5.6, 2.9,3.8,4.6)
#' tra <- factor(rep(c("T1","T2","T3"), times=6)); blo <- factor(rep(1:6, each=3))
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' friedman(judge = blo, trt = tra, evaluation = res, alpha = 0.05, group = FALSE, console = TRUE)
#' pchisq(Fr_calc, df = 2, lower.tail = FALSE) # P-valor manual
#' Nota: Bloques homogéneos o sin especificar. No requiere AD previo. Estadístico Fr ~ Chi2(k-1).
#'
#' 12. Quade (Posición)
#' library(PMCMRplus)
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' quade.test(y = res, groups = tra, blocks = blo) # Global
#' quadeAllPairsTest(y = res, g = tra, b = blo) # Comparaciones múltiples
#' pf(F_calc, df1 = 2, df2 = 10, lower.tail = FALSE) # P-valor manual
#' Alerta: Bloques heterogéneos / "más potente" / "mucha variabilidad entre bloques".
#'
#' 13. Page (Tendencia)
#' library(DescTools)
#' mat <- matrix(c(3.2,4.1,5.0, 2.8,3.9,4.7, 3.5,4.4,5.3, 2.6,3.6,4.4, 3.8,4.7,5.6, 2.9,3.8,4.6), nrow=6, byrow=TRUE)
#' colnames(mat) <- c("D1","D2","D3")
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Me1 <= Me2 <= Me3 (al menos una estricta)
#' PageTest(mat) # Tendencia creciente
#' PageTest(mat[, c("D3","D2","D1")]) # Tendencia decreciente (invertir columnas)
#' Alerta: No tiene argumento alternative. H0 siempre es igualdad. No requiere AD previo.
#'
#' 14. Friedman / Durbin (Posición - Bloques Incompletos)
#' library(agricolae)
#' blo <- c(1,1,1, 2,2,2, 3,3,3, 4,4,4, 5,5,5, 6,6,6)
#' tra <- c(1,2,3, 1,2,4, 1,3,4, 2,3,4, 1,2,3, 2,3,4)
#' res <- c(3.2,4.1,5.0, 2.8,3.9,4.4, 3.5,4.4,5.3, 2.6,3.6,4.7, 3.8,4.7,5.6, 2.9,3.8,4.6)
#' Hip -> H0: Me1 = Me2 = Me3 = Me4 vs H1: Al menos una Mei es diferente
#' durbin.test(judge = blo, trt = tra, evaluation = res, alpha = 0.05, group = FALSE, console = TRUE)
#' pchisq(D_calc, df = 3, lower.tail = FALSE) # P-valor manual
#' Alerta: Solo para bloques incompletos PLANIFICADOS y BALANCEADOS. Si son accidentales -> usar Skillings-Mack.
#'
#' 15. Skillings-Mack (Posición - Datos faltantes accidentales)
#' library(Skillings.Mack)
#' mat <- matrix(c(85,92,78,70, 88,95,81,73, 82,89,75,67, 86,93,79,71, 84,NA,77,NA, 87,94,80,69, 83,NA,76,75, 89,90,82,75), nrow=8, byrow=TRUE)
#' Hip -> H0: Me1 = Me2 = Me3 = Me4 vs H1: Al menos una Mei es diferente
#' Ski.Mack(mat)
#' Alerta: Recibe una MATRIZ con NA. Para bloques incompletos accidentales/no planificados.
#'
#' 16. Scheirer-Ray-Hare (Posición - Dos factores independientes)
#' library(rcompanion)
#' datos <- data.frame(y = c(12,15,14,13,16, 20,22,19,21,23, 18,17,19,20,16, 25,24,26,23,27, 30,28,31,29,32, 35,33,36,34,37), A = factor(rep(c("A1","A1","A2","A2","A3","A3"), each=5)), B = factor(rep(c("B1","B2"), times=15)))
#' Hip -> H0: No hay efecto del factor A / factor B / interacción AxB
#' scheirerRayHare(y ~ A + B, data = datos)
#' pchisq(H_calc, df = df_efecto, lower.tail = FALSE) # P-valor manual
#' Alerta: Verificar interacción PRIMERO. Requiere AD previo. Mínimo 5 repeticiones por celda.
#'
#' 17-18. Prueba de Permutación (Posición)
#' library(lmPerm)
#' y <- c(12,15,14,13,16, 20,22,19,21,23, 30,28,31,29,32); g <- factor(rep(c("G1","G2","G3"), each=5)); blo <- factor(rep(1:5, 3))
#' Hip -> H0: Me1 = Me2 = Me3 vs H1: Al menos una Mei es diferente
#' aovp(y ~ g) # K independientes
#' aovp(y ~ g + blo) # K relacionadas (con bloques)
#' # Nota: No depende de ninguna distribución teórica -> genera distribución empírica. No requiere AD previo.
#'
#' @param x Un argumento numérico o vector (sin uso analítico).
#' @export
ppqchis <- function(x) {
  # Esta función actúa únicamente como repositorio de documentación del bloque no paramétrico.
}
