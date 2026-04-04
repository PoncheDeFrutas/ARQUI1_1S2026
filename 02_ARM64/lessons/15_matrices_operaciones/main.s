/* =========================================================
 * Leccion 15 - Operaciones con matrices en ARM64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: aarch64-linux-gnu-as
 * Enlazador : aarch64-linux-gnu-ld
 * Ejecucion : qemu-aarch64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* Registros usados
 * x0  = fd para read/write y codigo de salida
 * x1  = direccion de buffers para syscalls
 * x2  = longitud para syscalls
 * x8  = numero de syscall
 * x10 = base del buffer de opcion
 * w11 = opcion leida del menu
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
menu:
    .ascii "1) suma 2x2\n"
    .ascii "2) resta 2x2\n"
    .ascii "3) escalar 2x2\n"
    .ascii "4) validar dimensiones\n"
    .ascii "Seleccion (1-4): "
menu_len = . - menu
opt: .space 2

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start
.extern demo_matrix_sum
.extern demo_matrix_sub
.extern demo_matrix_scalar
.extern demo_matrix_dim_check

_start:
    /* syscall: write(stdout, menu, menu_len) */
    mov x0,#1                    // stdout
    adr x1,menu                  // direccion del menu
    mov x2,menu_len              // longitud del menu
    mov x8,#64                   // syscall write
    svc #0                       // llamada al kernel

    /* syscall: read(stdin, opt, 2) */
    mov x0,#0                    // stdin
    adr x1,opt                   // buffer de opcion
    mov x2,#2                    // leer hasta 2 bytes
    mov x8,#63                   // syscall read
    svc #0                       // llamada al kernel

    adr x10,opt                  // base del buffer de opcion
    ldrb w11,[x10]               // leer primer caracter
    cmp w11,#'1'                 // demo 1?
    b.eq call_matrix_sum         // suma
    cmp w11,#'2'                 // demo 2?
    b.eq call_matrix_sub         // resta
    cmp w11,#'3'                 // demo 3?
    b.eq call_matrix_scalar      // escalar
    cmp w11,#'4'                 // demo 4?
    b.eq call_matrix_dim_check   // validar dimensiones
    mov x0,#1                    // opcion invalida
    b exit_program               // finalizar con error

call_matrix_sum:
    bl demo_matrix_sum           // validar suma matricial
    b exit_program               // salir con estado de la demo

call_matrix_sub:
    bl demo_matrix_sub           // validar resta matricial
    b exit_program               // salir con estado de la demo

call_matrix_scalar:
    bl demo_matrix_scalar        // validar multiplicacion por escalar
    b exit_program               // salir con estado de la demo

call_matrix_dim_check:
    bl demo_matrix_dim_check     // validar incompatibilidad

exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
