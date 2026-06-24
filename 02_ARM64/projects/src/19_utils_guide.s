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
start_line:
    .quad 1          // primera linea de datos

.balign 8
end_line:
    .quad 2          // ultima linea de datos

.bss

buffer:
    .skip 4096

char_out:
    .skip 1

.text
.global _start

_start:
    // cargar rango quemado
    ldr x0, =start_line
    ldr x24, [x0]          // x24 = linea inicial

    ldr x0, =end_line
    ldr x25, [x0]          // x25 = linea final

    // abrir archivo
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x3, #0
    mov x8, #56            // openat
    svc #0

    cmp x0, #0
    blt open_error

    mov x19, x0            // descriptor del archivo

    // leer archivo completo al buffer
    mov x0, x19
    ldr x1, =buffer
    mov x2, #4096
    mov x8, #63            // read
    svc #0

    cmp x0, #0
    blt read_error

    // cerrar archivo
    mov x0, x19
    mov x8, #57            // close
    svc #0

    // puntero al inicio del buffer
    ldr x21, =buffer

skip_header:
    ldrb w23, [x21], #1

    cmp w23, '\n'           // salto de linea
    beq first_data_line

    cmp w23, '$'           // fin logico del archivo
    beq end_program

    b skip_header

first_data_line:
    mov x22, #1            // linea actual de datos = 1

process_char:
    ldrb w23, [x21], #1

    cmp w23, '$'
    beq end_program

    cmp x22, x24
    blt check_newline

    cmp x22, x25
    bgt end_program

    ldr x1, =char_out
    strb w23, [x1]

    mov x0, #1
    mov x2, #1
    mov x8, #64            // write
    svc #0

check_newline:
    cmp w23, '\n'
    bne process_char

    // si encontramos el salto de linea
    add x22, x22, #1
    b process_char

open_error:
    mov x0, #1
    ldr x1, =err_open
    mov x2, len_err_open
    mov x8, #64
    svc #0
    b exit_error

read_error:
    mov x0, #1
    ldr x1, =err_read
    mov x2, len_err_read
    mov x8, #64
    svc #0
    b exit_error

end_program:
    mov x0, #0
    mov x8, #93
    svc #0

exit_error:
    mov x0, #1
    mov x8, #93
    svc #0
