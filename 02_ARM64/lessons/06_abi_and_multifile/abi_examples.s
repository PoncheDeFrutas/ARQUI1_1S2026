/* =========================================================
 * Leccion 06 - ABI y multiarchivo en ARM64 (Linux)
 * Archivo: abi_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Define funciones auxiliares ABI.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x0  = arg1 y retorno
 * x1  = arg2
 * x2  = arg3 (escala) en combine_and_scale
 * x19 = copia de escala (callee-saved)
 * x29 = frame pointer (fp)
 * x30 = link register (lr)
 * sp  = stack pointer
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global sum2
.global combine_and_scale

sum2:
    /* -----------------------------------------------------
     * Funcion: sum2(a, b)
     *
     * Entrada:
     *   x0 = a
     *   x1 = b
     * Salida:
     *   x0 = a + b
     *
     * Funcion leaf: no llama otras funciones.
     * ----------------------------------------------------- */
    add     x0, x0, x1           // x0 = a + b
    ret                          // volver al llamador


combine_and_scale:
    /* -----------------------------------------------------
     * Funcion: combine_and_scale(a, b, escala)
     *
     * Entrada:
     *   x0 = a
     *   x1 = b
     *   x2 = escala
     * Salida:
     *   x0 = (a + b) * escala
     * ----------------------------------------------------- */

    /* -----------------------------------------------------
     * 1) Prologo
     * -----------------------------------------------------
     * Guardamos fp/lr porque esta funcion llama a otra (no-leaf).
     * Guardamos x19 porque es callee-saved y lo vamos a usar.
     * un callee-saved es aquel que el llamador espera que se preserve tras la llamada.
     * ----------------------------------------------------- */
    stp     x29, x30, [sp, #-16]!    // push fp/lr
    mov     x29, sp                  // frame pointer actual
    str     x19, [sp, #-16]!         // push x19 (16-byte alignment)

    /* -----------------------------------------------------
     * 2) Preservar escala antes de llamar sum2
     * -----------------------------------------------------
     * x2 es caller-saved y puede cambiar tras una llamada.
     * Por eso copiamos escala a x19 (callee-saved).
     * ----------------------------------------------------- */
    mov     x19, x2              // x19 = escala

    /* -----------------------------------------------------
     * 3) Llamar sum2(a, b)
     * -----------------------------------------------------
     * Usa x0 y x1 como argumentos y retorna en x0.
     * ----------------------------------------------------- */
    bl      sum2                 // x0 = a + b

    /* -----------------------------------------------------
     * 4) Multiplicar por escala preservada
     * ----------------------------------------------------- */
    mul     x0, x0, x19          // x0 = (a + b) * escala

    /* -----------------------------------------------------
     * 5) Epilogo
     * ----------------------------------------------------- */
    ldr     x19, [sp], #16       // pop x19
    ldp     x29, x30, [sp], #16  // pop fp/lr
    ret                          // volver al llamador
