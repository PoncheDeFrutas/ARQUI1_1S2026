/* =========================================================
 * Modulo: entrada/salida
 * Archivo: io/print.s
 *
 * Arquitectura: ARMv8 / AArch64 Linux
 *
 * Proposito:
 *   Imprime cadenas, saltos de linea y enteros usando
 *   syscalls Linux sin libc.
 *
 * Simbolos publicos:
 *   print_string
 *   print_newline
 *   print_i64
 *   strlen
 *
 * Dependencias:
 *   constants.inc
 * ========================================================= */

.include "constants.inc"

.section .rodata
newline_str:
    .asciz "\n"
minus_str:
    .asciz "-"

.section .bss
    .align 3
output_buffer:
    .skip OUTPUT_BUF_SIZE

.section .text
.global print_string
.global print_newline
.global print_i64
.global strlen

/* ---------------------------------------------------------
 * Funcion: print_string
 *
 * Objetivo:
 *   Escribir cadena terminada en NUL hacia stdout.
 *
 * Entradas:
 *   x0 = direccion de cadena ASCIZ
 *
 * Salidas:
 *   x0 = ERR_OK
 *
 * Registros usados:
 *   x19 = direccion original de cadena
 *   x0/x1/x2/x8 = argumentos de syscall write
 *
 * Procedimiento:
 *   1) Calcular longitud con strlen.
 *   2) Preparar write(stdout, cadena, longitud).
 *   3) Ejecutar svc #0.
 * --------------------------------------------------------- */
print_string:
    stp x29, x30, [sp, #-32]!
    mov x29, sp
    str x19, [sp, #16]

    mov x19, x0
    bl strlen
    mov x2, x0
    mov x0, #STDOUT
    mov x1, x19
    mov x8, #SYS_WRITE
    svc #0
    mov x0, #ERR_OK

    ldr x19, [sp, #16]
    ldp x29, x30, [sp], #32
    ret

/* ---------------------------------------------------------
 * Funcion: print_newline
 *
 * Objetivo:
 *   Imprimir salto de linea.
 *
 * Entradas:
 *   ninguna
 *
 * Salidas:
 *   x0 = ERR_OK
 *
 * Procedimiento:
 *   1) Cargar direccion de newline_str.
 *   2) Reutilizar print_string.
 * --------------------------------------------------------- */
print_newline:
    stp x29, x30, [sp, #-16]!
    mov x29, sp
    ldr x0, =newline_str
    bl print_string
    ldp x29, x30, [sp], #16
    ret

/* ---------------------------------------------------------
 * Funcion: strlen
 *
 * Objetivo:
 *   Contar bytes hasta byte NUL.
 *
 * Entradas:
 *   x0 = direccion de cadena ASCIZ
 *
 * Salidas:
 *   x0 = longitud en bytes
 *
 * Registros usados:
 *   x1 = direccion base
 *   w2 = byte actual
 * --------------------------------------------------------- */
strlen:
    mov x1, x0
    mov x0, #0
strlen_loop:
    ldrb w2, [x1, x0]
    cbz w2, strlen_done
    add x0, x0, #1
    b strlen_loop
strlen_done:
    ret

/* ---------------------------------------------------------
 * Funcion: print_i64
 *
 * Objetivo:
 *   Imprimir entero con signo en base 10.
 *
 * Entradas:
 *   x0 = entero signed 64-bit
 *
 * Salidas:
 *   x0 = ERR_OK
 *
 * Registros usados:
 *   x19 = valor restante
 *   x20 = cursor dentro de output_buffer
 *   x21 = divisor 10
 *
 * Procedimiento:
 *   1) Si valor es negativo, imprimir '-' y negarlo.
 *   2) Construir digitos desde el final del buffer.
 *   3) Dividir repetidamente entre 10.
 *   4) Imprimir cadena resultante con print_string.
 * --------------------------------------------------------- */
print_i64:
    stp x29, x30, [sp, #-48]!
    mov x29, sp
    stp x19, x20, [sp, #16]
    str x21, [sp, #32]

    mov x19, x0
    cmp x19, #0
    b.ge print_i64_positive
    ldr x0, =minus_str
    bl print_string
    neg x19, x19

print_i64_positive:
    ldr x20, =output_buffer
    add x20, x20, #OUTPUT_BUF_SIZE
    sub x20, x20, #1
    strb wzr, [x20]
    mov x21, #10

    cbnz x19, print_i64_loop
    sub x20, x20, #1
    mov w0, #'0'
    strb w0, [x20]
    b print_i64_emit

print_i64_loop:
    /* 3) Cociente en x0, residuo decimal en x1. */
    udiv x0, x19, x21
    msub x1, x0, x21, x19
    add x1, x1, #'0'
    sub x20, x20, #1
    strb w1, [x20]
    mov x19, x0
    cbnz x19, print_i64_loop

print_i64_emit:
    mov x0, x20
    bl print_string

    ldr x21, [sp, #32]
    ldp x19, x20, [sp, #16]
    ldp x29, x30, [sp], #48
    ret
