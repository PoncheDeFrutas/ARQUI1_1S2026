/* =========================================================
 * main.s
 * Punto de entrada del programa (_start)
 * Llama a la función sumar y termina el programa
 * ========================================================= */

.section .text
.global _start

.extern sum        // función definida en otro archivo

_start:
    /* -----------------------------------------
     * Preparar argumentos para sumar(a, b)
     * ----------------------------------------- */
    mov x0, #5      // a = 5
    mov x1, #10     // b = 10

    bl sum          // llamada a la función
                    // resultado queda en x0 (5 + 10 = 15)

    /* -----------------------------------------
     * Finalizar el programa
     * Usamos el resultado como código de salida
     * ----------------------------------------- */
    mov x8, #93     // syscall: exit
    svc #0
