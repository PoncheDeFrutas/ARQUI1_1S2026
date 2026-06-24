// millis.s

.bss
.balign 8
timespec_buffer:
    .skip 16              // struct timespec: tv_sec + ctv_nse

.text

// millis()
// Retorna:
//   x0 = tiempo actual en milisegundos
millis:
    // clock_gettime(CLOCK_MONOTONIC, &timespec_buffer)
    mov x0, #1            // CLOCK_MONOTONIC
    ldr x1, =timespec_buffer
    mov x8, #113          // syscall clock_gettime
    svc #0

    // Cargar segundos y nanosegundos
    ldr x2, =timespec_buffer
    ldr x0, [x2]          // tv_sec
    ldr x1, [x2, #8]      // tv_nsec

    // ms = tv_sec * 1000
    mov x3, #1000
    mul x0, x0, x3

    // ms += tv_nsec / 1000000
    ldr x3, =1000000
    udiv x1, x1, x3
    add x0, x0, x1

    ret
