/* =========================================================
 * Leccion 12 - Tipos y extension de signo/cero en ARM64
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
 * x1  = valor cargado desde memoria
 * x2  = bytes a leer/escribir
 * x8  = numero de syscall
 * x10 = base de buffer/opcion o dato
 * w11 = opcion leida del menu
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
menu: .ascii "1) ldrb zero extension\n2) ldrsb sign extension\nSeleccion (1-2): "  // texto menu
menu_len = . - menu                                                            // longitud menu
opt: .space 2                                                                  // buffer opcion
b0: .byte 0xF2                                                                 // byte de prueba

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * syscall: write(stdout, menu, menu_len)
     * ----------------------------------------------------- */
    mov     x0, #1               // stdout
    adr     x1, menu             // direccion del menu
    mov     x2, menu_len         // longitud del menu
    mov     x8, #64              // syscall write
    svc     #0                   // llamada al kernel

    /* -----------------------------------------------------
     * syscall: read(stdin, opt, 2)
     * ----------------------------------------------------- */
    mov     x0, #0               // stdin
    adr     x1, opt              // buffer de opcion
    mov     x2, #2               // leer 2 bytes maximo
    mov     x8, #63              // syscall read
    svc     #0                   // llamada al kernel

    adr x10,opt                  // base del buffer
    ldrb w11,[x10]               // primer caracter leido
    cmp w11,#'2'                 // opcion 2?
    b.eq demo_sign               // ir a demo de signo

demo_zero:
    /* ldrb: carga byte y extiende con ceros */
    adr x10,b0                   // direccion del byte
    ldrb w1,[x10]                // zero extension
    cmp x1,#0xF2                 // validar valor unsigned
    b.ne error                   // error si no coincide
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

demo_sign:
    /* ldrsb: carga byte y extiende signo */
    adr x10,b0                   // direccion del byte
    ldrsb x1,[x10]               // sign extension
    cmp x1,#-14                  // validar valor signed
    b.ne error                   // error si no coincide
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

error:
    mov x0,#1                    // codigo de error

exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
