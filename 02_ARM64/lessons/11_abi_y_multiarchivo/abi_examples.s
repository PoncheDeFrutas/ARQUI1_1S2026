/* =========================================================
 * Leccion 11 - ABI y multiarchivo en ARM64 (Linux)
 * Archivo: abi_examples.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc. Contiene funciones auxiliares.
 * ========================================================= */

/* Registros usados
 * x0 = arg1 y retorno
 * x1 = arg2
 * x2 = arg3 (escala)
 * x19 = copia de escala (callee-saved)
 * x29 = frame pointer
 * x30 = link register
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Este modulo no requiere datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global sum2
.global combine_and_scale

sum2:
    /* Funcion leaf: retorna a+b en x0 */
    add x0,x0,x1                  // x0 = a + b
    ret                           // volver al llamador

combine_and_scale:
    /* Prologo de funcion no-leaf */
    stp x29,x30,[sp,#-16]!        // guardar fp/lr
    mov x29,sp                    // nuevo frame pointer
    str x19,[sp,#-16]!            // guardar x19

    /* Preservar escala y llamar sum2 */
    mov x19,x2                    // preservar escala
    bl sum2                       // x0 = a + b

    /* Multiplicar resultado por escala */
    mul x0,x0,x19                 // x0 = (a+b)*escala

    /* Epilogo */
    ldr x19,[sp],#16              // restaurar x19
    ldp x29,x30,[sp],#16          // restaurar fp/lr
    ret                           // volver al llamador
