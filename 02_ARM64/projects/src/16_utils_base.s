.data

filename:
    .asciz "lecturas.csv"

err_open:
    .ascii "Error al abrir el archivo\n"
    len_err_open = . - err_open

err_read:
    .ascii "Error al leer el archivo\n"
    len_err_read = . - err_read

.bss

buffer:
    .skip 32

.text
.global _start

_start:
    // contador de lineas
    mov x24, #0

    // openat
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x3, #0
    mov x8, #56
    svc #0

    cmp x0, #0
    blt error_open

    mov x19, x0     //fd

loop_read:
    // read
    mov x0, x19
    ldr x1, =buffer
    mov x2, #32
    mov x8, #63         // read
    svc #0

    cmp x0, #0
    blt error_read
    beq end_read

    mov x20, x0     // bytes leidos

    bl process_buffer

    b loop_read

process_buffer:
    ldr x21, =buffer
    mov x22, #0

process_loop:
    cmp x22, x20
    bge end_process

    ldrb w23, [x21], #1
    add x22, x22, #1

    cmp w23, #10
    bne process_loop

    // contador de lineas
    add x24, x24, #1

    b process_loop

end_process:
    ret

end_read:
    mov x0, x19
    mov x8, #57         // close
    svc #0

    mov x0, x24
    b exit

error_open:
    ldr x1, =err_open
    ldr x2, =len_err_open
    b print_error
error_read:
    ldr x1, =err_read
    ldr x2, =len_err_read

print_error:
    mov x0, #1
    mov x8, #64
    svc #0

    mov x0, #1
    mov x8, #93
    svc #0
    mov x0, #1

exit:
    mov x8, #93
    svc #0
