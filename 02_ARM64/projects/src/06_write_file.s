.data
path:
    .asciz "output.txt"

mgs:
    .ascii "Hello, World!"
    mgs_len = . - mgs

mgs_err:
    .ascii "Failed to write to file.\n"
    mgs_err_len = . - mgs_err

.text
.global _start

_start:
    // OPENAT(AT_FDCWD, "output.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644)
    mov x0, #-100
    adr x1, path
    mov x2, #(1 | 64 | 512) // O_WRONLY | O_CREAT | O_TRUNC
    mov x3, #420 // 0644 en octal
    mov x8, #56 // syscall openat
    svc #0

    cmp x0, #0
    blt error
    mov x19, x0 // Guardar el descriptor de archivo

    // write(x19, mgs, mgs_len)
    mov x0, x19                     // fd
    adr x1, mgs                     // buf
    mov x2, mgs_len                 // count
    mov x8, #64                     // syscall write
    svc #0

    // verificar el retorno de write
    cmp x0, #0
    blt error

    // CLOSE(x19)
    mov x0, x19
    mov x8, #57 // syscall close
    svc #0

    // EXIT(0)
    mov x0, #0
    mov x8, #93 // syscall exit
    svc #0

error:
    // write(STDOUT, mgs_err, mgs_err_len)
    mov x0, #1          // STDOUT
    ldr x1, =mgs_err     // Dirección del mensaje de error
    mov x2, mgs_err_len  // Longitud del mensaje de error
    mov x8, #64         // syscall write
    svc #0

    // EXIT(1)
    mov x0, #1          // Código de salida
    mov x8, #93         // syscall exit
    svc #0
