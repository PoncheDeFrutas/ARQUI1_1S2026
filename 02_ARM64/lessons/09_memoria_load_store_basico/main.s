/* =========================================================
 * Leccion 09 - Memoria load/store basico en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* Registros usados
 * x10 = direccion base del bloque de datos
 * x1  = valor a
 * x2  = valor b
 * x3  = resultado a+b
 * x4  = valor releido desde memoria
 * x0  = codigo de salida
 * x8  = syscall exit
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
a: .quad 10                       // primer valor
b: .quad 20                       // segundo valor
r: .quad 0                        // resultado

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* Obtener base y leer dos valores */
    adr x10,a                     // x10 = direccion base
    ldr x1,[x10,#0]               // x1 = a
    ldr x2,[x10,#8]               // x2 = b

    /* Operar y guardar resultado */
    add x3,x1,x2                  // x3 = a + b
    str x3,[x10,#16]              // guardar resultado

    /* Releer y validar */
    ldr x4,[x10,#16]              // releer resultado
    cmp x4,#30                    // validar resultado esperado
    b.ne error                    // error si no es 30
    mov x0,#0                     // codigo de exito
    b exit_program                // finalizar
error:
    mov x0,#1                     // codigo de error
exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                    // syscall exit
    svc #0                        // llamada al kernel
