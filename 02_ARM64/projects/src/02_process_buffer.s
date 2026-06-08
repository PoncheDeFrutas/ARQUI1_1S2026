.data

filename:
    .asciz "lecturas.csv"

err_open:
    .asciz "Error al abrir el archivo\n"
    len_err_open = . - err_open

err_read:
    .asciz "Error al leer el archivo\n"
    len_err_read = . - err_read

.bss
buffer:
    .skip 4096


.text

.global _start


_start:
    // OPENAT(AT_FDCWD, filename, O_RDONLY)
    mov x0, #-100                   // AT_FDCWD (Directorio Actual)
    ldr x1, =filename               // Dirección del nombre del archivo
    mov x2, #0                      // O_RDONLY
    mov x3, #0                      // No flags
    mov x8, #56                     // syscall: openat
    svc #0

    // Verificar si el archivo se abrió correctamente
    cmp x0, #0
    blt open_error

    // Guardar el descriptor de archivo
    mov x19, x0                     // Guardar el descriptor de archivo en x19


read_loop:
    // READ(x19, buffer, 4096)
    mov x0, x19                     // Descriptor de archivo
    ldr x1, =buffer                 // Dirección del buffer
    mov x2, #4096                 // Tamaño a leer
    mov x8, #63                     // syscall: read
    svc #0

    // Verificar si la lectura fue exitosa
    cmp x0, #0
    blt read_error

    cbz x0, end_read                // Si no se leyeron más bytes, terminar

    mov x20, x0                     // Guardar el número de bytes leídos en x20

    ldr x21, =buffer                // Dirección del buffer
    mov x22, x20                    // Número de bytes leídos

process_buffer:
    // Aquí puedes procesar el buffer según tus necesidades
    cbz x22, read_loop                     // Si no hay más bytes para procesar, volver a leer

    ldrb w23, [x21], #1

    cmp w23, '$'
    beq end_read

    mov x0, #1                      // STDOUT
    mov x1, x21                     // Dirección del byte actual en el buffer
    mov x2, #1                      // Escribir un byte
    mov x8, #64                     // syscall: write
    svc #0

    sub x22, x22, #1                     // Decrementar el contador de bytes restantes

    b process_buffer                     // Volver a leer el siguiente bloque

open_error:
    // impresion mensaje
    mov x0, #1                      // STDOUT
    ldr x1, =err_open               // Dirección del mensaje de error
    mov x2, len_err_open            // Longitud del mensaje de error
    mov x8, #64                     // syscall: write
    svc #0

    // EXIT(1)
    mov x0, #1                      // STDOUT
    mov x8, #93
    svc #0

read_error:
    // impresion mensaje
    mov x0, #1                      // STDOUT
    ldr x1, =err_read               // Dirección del mensaje de error
    mov x2, len_err_read            // Longitud del mensaje de error
    mov x8, #64                     // syscall: write
    svc #0

    // EXIT(2)
    mov x0, #2                      // STDOUT
    mov x8, #93
    svc #0

end_read:
    // Cerrar el archivo
    mov  x0, x19                     // Descriptor de archivo
    mov  x8, #57                     // syscall: close
    svc #0

    // EXIT(0)
    mov x0, #0                      // STDOUT
    mov x8, #93
    svc #0
