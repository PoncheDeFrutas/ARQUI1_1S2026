.data

array:
    .quad 0, 0, 0, 0, 0

cantidad:
    .quad 0

.text
.global _start

_start:
    mov x20, #1 // dato inicial, o contador inicial
    mov x21, #10 // cantidad de datos a guardar
    mov x22, #0 // contador

// ESTE LOOP ES REEMPLAZABLE
// LOGICA DE EJEMPLO, EL LOOP PUEDE SER EL MOTOR
loop:
    cmp x22, x21 // comparar contador con cantidad
    beq end_program

    mov x0, x20
    bl guardar_dato

    add x20, x20, #1 // incrementar dato
    add x22, x22, #1 // incrementar contador
    b loop

guardar_dato:
    ldr x1, =cantidad
    ldr x2, [x1]

desplazar_array:
    // SE PUEDE QUITAR LO SIGUIENTE
    // SE MANDA X3 ANTES DE HACER UN BL A GUARDAR DATO
    ldr x3, =array

    ldr x4, [x3, #8]
    str x4, [x3, #0]

    ldr x4, [x3, #16]
    str x4, [x3, #8]

    ldr x4, [x3, #24]
    str x4, [x3, #16]

    ldr x4, [x3, #32]
    str x4, [x3, #24]

    str x0, [x3, #32]

    ret

end_program:
    // Salir del programa
    mov x0, #0
    mov x8, #93
    svc 0

