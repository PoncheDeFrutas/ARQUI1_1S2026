/* =========================================================
 * sumar.s
 * Función: sumar(a, b)
 *
 * Convención AArch64:
 *   x0 -> primer argumento
 *   x1 -> segundo argumento
 *   x0 <- valor de retorno
 * ========================================================= */

.section .text
.global sum

sum:
    add x0, x0, x1   // x0 = x0 + x1
    ret              // regresar al llamador
