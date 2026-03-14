/* =========================================================
 * Leccion 10 - Stack y funciones en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* Registros usados
 * x0  = argumento de funcion y valor de retorno
 * x8  = numero de syscall
 * x19 = contador local (callee-saved)
 * x20 = acumulador local (callee-saved)
 * x29 = frame pointer
 * x30 = link register
 * sp  = stack pointer
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * ---------------------------------------------------------
 * Esta leccion no requiere datos estaticos.
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* Llamar suma_1_a_n(5) y validar retorno 15 */
    mov x0,#5                     // argumento n = 5
    bl suma_1_a_n                 // llamar funcion
    cmp x0,#15                    // validar retorno
    b.ne error                    // error si no es 15
    mov x0,#0                     // codigo de exito
    b exit_program                // finalizar
error:
    mov x0,#1                     // codigo de error
exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                    // syscall exit
    svc #0                        // llamada al kernel

suma_1_a_n:
    /* Prologo: guardar contexto de llamada */
    stp x29,x30,[sp,#-16]!        // guardar fp/lr
    mov x29,sp                    // nuevo frame pointer
    stp x19,x20,[sp,#-16]!        // guardar x19/x20

    /* Variables locales */
    mov x19,x0                    // contador = n
    mov x20,#0                    // acumulador = 0

loop:
    /* while (x19 > 0) { x20 += x19; x19--; } */
    cmp x19,#0                    // while (contador > 0)
    b.le end                      // salir si contador <= 0
    add x20,x20,x19               // acumular
    sub x19,x19,#1                // contador--
    b loop                        // repetir

end:
    /* Epilogo: restaurar y retornar */
    mov x0,x20                    // retorno en x0
    ldp x19,x20,[sp],#16          // restaurar x19/x20
    ldp x29,x30,[sp],#16          // restaurar fp/lr
    ret                           // volver al llamador
