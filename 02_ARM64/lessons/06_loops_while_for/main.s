/* =========================================================
 * Leccion 06 - Loops while/for en ARM64 (Linux)
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
 * x1  = contador i
 * x2  = acumulador suma
 * x8  = numero de syscall
 * x10 = base de buffer de opcion
 * w11 = opcion leida del menu
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
menu: .ascii "1) while suma 1..5\n2) for suma 1..5\nSeleccion (1-2): "
menu_len = . - menu
opt: .space 2

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

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
    mov x2,#2                    // leer 2 bytes maximo
    mov x8,#63                   // syscall read
    svc #0                       // llamada al kernel

    adr x10,opt                  // base del buffer
    ldrb w11,[x10]               // leer primer caracter
    cmp w11,#'2'                 // comparar opcion con '2'
    b.eq demo_for                // si es '2', ir a for

demo_while:
    /* while (i <= 5) { suma += i; i++; } */
    mov x1,#1                    // i = 1
    mov x2,#0                    // suma = 0
while_check:
    cmp x1,#5                    // while (i <= 5)
    b.gt validate                // salir si i > 5
    add x2,x2,x1                 // suma += i
    add x1,x1,#1                 // i++
    b while_check                // repetir while

demo_for:
    /* for (i=1; i<=5; i++) suma += i; */
    mov x1,#1                    // i = 1
    mov x2,#0                    // suma = 0
for_loop:
    cmp x1,#5                    // for condicion i <= 5
    b.gt validate                // salir si i > 5
    add x2,x2,x1                 // suma += i
    add x1,x1,#1                 // i++
    b for_loop                   // repetir for

validate:
    cmp x2,#15                   // validar suma esperada
    b.ne error                   // si no es 15, error
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar
error:
    mov x0,#1                    // codigo de error
exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
