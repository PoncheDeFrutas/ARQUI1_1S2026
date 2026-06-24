.data

dev_gpiomem:
    .asciz "/dev/gpiomem"

.text

.global _start

.equ GPIO_PIN, 18

.equ GPFSEL1, 0x04
.equ GPSET0,  0x1C
.equ GPCLR0,  0x28

.equ BLOCK_SIZE, 4096
.equ PROT_READ_WRITE, 3
.equ MAP_SHARED, 1

.equ INTERVAL_MS, 1000

.include "millis.s"

_start:
    // Abrir /dev/gpiomem
    mov x0, #-100
    ldr x1, =dev_gpiomem
    mov x2, #2
    mov x3, #0
    mov x8, #56
    svc #0

    // Verificar error al abrir
    cmp x0, #0
    blt exit_error

    // Guardar descriptor
    mov x19, x0

    // Mapear memoria GPIO
    mov x0, #0
    mov x1, #BLOCK_SIZE
    mov x2, #PROT_READ_WRITE
    mov x3, #MAP_SHARED
    mov x4, x19
    mov x5, #0
    mov x8, #222            // mmap
    svc #0

    // Verificar error al mapear
    cmp x0, #0
    blt exit_error

    // Guardar base GPIO
    mov x20, x0

    // Configurar GPIO18 como salida
    ldr w1, [x20, #GPFSEL1]

    mov w2, #7
    lsl w2, w2, #24
    bic w1, w1, w2

    mov w2, #1
    lsl w2, w2, #24
    orr w1, w1, w2

    str w1, [x20, #GPFSEL1]

    // Estado inicial apagado
    mov x21, #0

    // Guardar tiempo inicial
    bl millis
    mov x22, x0

main_loop:
    // Obtener tiempo actual
    bl millis
    mov x23, x0

    // Calcular tiempo transcurrido
    sub x24, x23, x22

    // Esperar intervalo
    cmp x24, #INTERVAL_MS
    blt main_loop

    // Actualizar tiempo anterior
    mov x22, x23

    // Revisar estado del LED
    cmp x21, #0
    beq turn_on

turn_off:
    // Apagar GPIO18
    mov w1, #1
    lsl w1, w1, #GPIO_PIN
    str w1, [x20, #GPCLR0]

    // Guardar estado apagado
    mov x21, #0

    b main_loop

turn_on:
    // Encender GPIO18
    mov w1, #1
    lsl w1, w1, #GPIO_PIN
    str w1, [x20, #GPSET0]

    // Guardar estado encendido
    mov x21, #1

    b main_loop

exit_error:
    // Salir con error
    mov x0, #1
    mov x8, #93
    svc #0

