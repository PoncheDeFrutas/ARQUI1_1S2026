/* =========================================================
 * Leccion 13 - Arreglos 1D en ARM64 (Linux)
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
    .ascii "1) leer arr[2]\n"
    .ascii "2) reemplazar arr[1]\n"
    .ascii "3) buscar valor\n"
    .ascii "4) contar 'a' en banana\n"
    .ascii "Seleccion (1-4): "
menu_len = . - menu
opt: .space 2

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start
.extern demo_read_index
.extern demo_replace_index
.extern demo_linear_search
.extern demo_count_char

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
    b.eq call_read_index         // ir a lectura por indice
    cmp w11,#'2'                 // demo 2?
    b.eq call_replace_index      // ir a reemplazo
    cmp w11,#'3'                 // demo 3?
    b.eq call_linear_search      // ir a busqueda
    cmp w11,#'4'                 // demo 4?
    b.eq call_count_char         // ir a texto ASCII
    mov x0,#1                    // opcion invalida
    b exit_program               // finalizar con error

call_read_index:
    bl demo_read_index           // validar lectura arr[2]
    b exit_program               // salir con estado de la demo

call_replace_index:
    bl demo_replace_index        // validar reemplazo arr[1]
    b exit_program               // salir con estado de la demo

call_linear_search:
    bl demo_linear_search        // validar busqueda encontrada y no encontrada
    b exit_program               // salir con estado de la demo

call_count_char:
    bl demo_count_char           // validar recorrido de string

exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
