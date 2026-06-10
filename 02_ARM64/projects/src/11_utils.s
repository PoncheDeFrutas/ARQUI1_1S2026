// 11_utils_stack.s
//
// Entrada:
//   x11 = columna seleccionada
//
// Salida:
//   x0 = inicio de datos en stack
//   x1 = limite final de datos
//   x2 = cantidad de numeros guardados
//   x3 = posicion para restaurar stack

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
    .skip 4096

.text

.include "10_atoi_num.s"

read_column_to_stack:
    // guardar direccion de retorno
    stp x29, x30, [sp, #-16]!
    mov x29, sp

    // x28 = limite superior de datos
    mov x28, sp

    // x27 = posicion para restaurar stack
    add x27, x28, #16

    mov x5, #10             // base 10
    mov x22, #0             // contador de numeros

    // abrir archivo
    bl utils_open_file

    // leer archivo
    bl utils_read_file

    // cerrar archivo
    bl utils_close_file

    // apuntar al inicio del buffer
    ldr x21, =buffer

    // saltar encabezado
    bl utils_skip_to_next_line

    cmp w23, '$'
    beq utils_done

utils_process_line:
    mov x12, #1             // columna actual

utils_find_column:
    cmp x12, x11
    beq utils_read_column

    bl utils_skip_to_next_column

    cmp w23, '$'
    beq utils_done

    cmp w23, #10
    beq utils_process_line

    // si fue coma, avanzar contador de columna
    add x12, x12, #1
    b utils_find_column

utils_read_column:
    bl atoi_csv

    cbz x7, utils_after_column

    // guardar numero convertido
    bl utils_save_number

// despues de leer la columna, saltar al final de la linea
utils_after_column:
    cmp w23, '$'
    beq utils_done

    cmp w23, #10
    beq utils_process_line

    // saltar el resto de la fila
    bl utils_skip_to_next_line

    cmp w23, '$'
    beq utils_done

    b utils_process_line

utils_done:
    mov x0, sp              // inicio de datos
    mov x1, x28             // limite final
    mov x2, x22             // cantidad de datos
    mov x3, x27             // restaurar stack

    // recuperar direccion original de retorno
    // [X29, X30] 
    ldr x30, [x29, #8]
    ret

// Abrir archivo
utils_open_file:
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x3, #0
    mov x8, #56
    svc #0

    cmp x0, #0
    blt utils_open_error

    mov x19, x0
    ret

// Leer archivo
utils_read_file:
    mov x0, x19
    ldr x1, =buffer
    mov x2, #4096
    mov x8, #63
    svc #0

    cmp x0, #0
    blt utils_read_error

    mov x20, x0
    ret

// Cerrar archivo
utils_close_file:
    mov x0, x19
    mov x8, #57
    svc #0
    ret

// Saltar hasta nueva linea o fin
utils_skip_to_next_line:
    ldrb w23, [x21], #1

    cmp w23, '$'
    beq utils_skip_done

    cmp w23, #10
    beq utils_skip_done

    b utils_skip_to_next_line

// Saltar hasta coma, nueva linea o fin
utils_skip_to_next_column:
    ldrb w23, [x21], #1

    cmp w23, '$'
    beq utils_skip_done

    cmp w23, #10
    beq utils_skip_done

    cmp w23, ','
    beq utils_skip_done

    b utils_skip_to_next_column

utils_skip_done:
    ret

// Guardar numero en stack
utils_save_number:
    sub sp, sp, #16
    str x10, [sp]

    add x22, x22, #1
    ret

// Manejo de errrores
utils_open_error:
    mov x0, #1
    ldr x1, =err_open
    mov x2, len_err_open
    mov x8, #64
    svc #0
    b utils_exit_error

utils_read_error:
    mov x0, #1
    ldr x1, =err_read
    mov x2, len_err_read
    mov x8, #64
    svc #0
    b utils_exit_error

utils_exit_error:
    mov x0, #1
    mov x8, #93
    svc #0
