.data

filename:
    .asciz "lecturas.csv"

err_open:
    .ascii "Error al abrir el archivo\n"
    len_err_open = . - err_open

err_read:
    .ascii "Error al leer el archivo\n"
    len_err_read = . - err_read

.balign 8
select_column:
    .quad 2                 // 1 = ID | 2 = Temperatura | 3 = Humedad

.bss
buffer:
    .skip 4096

.text
.global _start
.include "07_atoi_b.s"

_start:
    mov x5, #10            // base 10
    mov x6, #0             // contador numeros

    ldr x0, =select_column
    ldr x11, [x0]

    // openat
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x3, #0
    mov x8, #56                // syscall openat
    svc #0

    // verificar si openat fue exitoso
    cmp x0, #0
    blt open_error

    mov x19, x0            // guardar descriptor de archivo

    // read
    mov x0, x19
    ldr x1, =buffer
    mov x2, #4096
    mov x8, #63             // syscall read
    svc #0

    // verificar si read fue exitoso
    cmp x0, #0
    blt read_error

    // x20 = bytes leidos
    mov x20, x0

    // cerrar archivo
    mov x0, x19
    mov x8, #57             // syscall close
    svc #0

    // x21 = puntero actual dentro del buffer
    ldr x21, =buffer

skip_header:
    // lectura del dato y aumentamos en 1
    ldrb w23, [x21], #1

    cmp w23, #10
    beq process_line

    cmp w23, '$'
    beq end_program

    b skip_header

process_line:
    // x12 = contador de columnas
    mov x12, #1

skip_columns:
    // llegamos a la columna deseada
    cmp x12, x11
    beq read_column

    // saltar caracteres hasta en contrar una coma
    ldrb w23, [x21], #1

    cmp w23, '$'
    beq end_program

    cmp w23, #10
    beq process_line

    cmp w23, ','
    bne skip_columns

    add x12, x12, #1
    b skip_columns

read_column:
    bl atoi_csv

    cbz x7, after_column

    // x10 = numero convertido
    sub sp, sp, #16
    str x10, [sp]           // guardar resultado en stack

    add x6, x6, #1          // contador numeros

    mov x10, #0             // resultado = 0
    mov x7, #0              // bandera de numero activo

after_column:
    cmp w23, '$'
    beq end_program
    cmp w23, #10
    beq process_line

skip_rest_of_line:
    ldrb w23, [x21], #1
    cmp w23, '$'
    beq end_program
    cmp w23, #10
    beq process_line

    b skip_rest_of_line

end_program:
    mov x0, #0             // exit code
    mov x8, #93            // syscall exit
    svc #0

read_error:
    ldr x1, =err_read
    mov x2, len_err_read
    b error_exit

open_error:
    ldr x1, =err_open
    mov x2, len_err_open

error_exit:
    mov x0, #1             // stdout
    mov x8, #64            // syscall write
    svc #0

    mov x0, #1             // exit
    mov x8, #93            // syscall exit
    svc #0
