/* =========================================================
 * Leccion 08 - ALU logica y bits en ARM64 (Linux)
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
 * x1,x2 = operandos logicos
 * x3,x4,x5 = resultados de operaciones
 * x8  = numero de syscall
 * x10 = base del buffer de opcion
 * w11 = opcion del menu
 */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .data
menu: .ascii "1) and/orr/eor\n2) shifts\nSeleccion (1-2): "
menu_len = . - menu
opt: .space 2

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
    ldrb w11,[x10]               // primer caracter
    cmp w11,#'2'                 // opcion 2?
    b.eq demo_shift              // ir a demo shifts

demo_logic:
    /* Demo 1: operaciones logicas bit a bit */
    mov x1,#0b1100               // operando A
    mov x2,#0b1010               // operando B
    and x3,x1,x2      // 1000 = 8
    orr x4,x1,x2      // 1110 = 14
    eor x5,x1,x2      // 0110 = 6
    cmp x3,#8                    // validar AND
    b.ne error                   // error si falla
    cmp x4,#14                   // validar ORR
    b.ne error                   // error si falla
    cmp x5,#6                    // validar EOR
    b.ne error                   // error si falla
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

demo_shift:
    /* Demo 2: desplazamientos */
    mov x1,#3                    // valor base
    lsl x2,x1,#2      // 12
    lsr x3,x2,#1      // 6
    cmp x2,#12                   // validar LSL
    b.ne error                   // error si falla
    cmp x3,#6                    // validar LSR
    b.ne error                   // error si falla
    mov x0,#0                    // codigo de exito
    b exit_program               // finalizar

error:
    mov x0,#1                    // codigo de error
exit_program:
    /* syscall: exit(x0) */
    mov x8,#93                   // syscall exit
    svc #0                       // llamada al kernel
