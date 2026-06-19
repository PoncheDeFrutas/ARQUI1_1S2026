.data

array:
    .quad 0, 0, 0, 0, 0

array_2:
    .quad 0, 0, 0, 0, 0

posicion:
    .quad 0

posicion_2:
    .quad 0

cantidad:
    .quad 0

.text

.global _start

_start:
    mov x0, #1
    ldr x1, =posicion
    ldr x3, =array
    bl guardar_dato


    mov x0, #2
    ldr x1, =posicion
    ldr x3, =array
    bl guardar_dato

    mov x0, #3
    ldr x1, =posicion_2
    ldr x3, =array_2
    bl guardar_dato

    mov x0, #4
    ldr x1, =posicion
    ldr x3, =array
    bl guardar_dato

    mov x0, #5
    ldr x1, =posicion_2
    ldr x3, =array_2
    bl guardar_dato

    mov x0, #6
    ldr x1, =posicion
    ldr x3, =array
    bl guardar_dato

    mov x0, #0
    mov x8, #93
    svc #0

guardar_dato:
    // en x0 esta el dato a guardar
    // en x3 esta el array al quiero guardar
    // en x1 esta la posicion a guardar
    ldr x2, [x1]

    mov x4, #8
    mul x5, x2, x4

    // x3 es la posicion del array
    // x5 es el offset dependiendo del array
    add x6, x3, x5

    // store x0
    str x0, [x6]

    add x2, x2, #1
    cmp x2, #5
    bne guardar_posicion

    mov x2, #0

guardar_posicion:
    str x2, [x1]

    ldr x7, =cantidad
    ldr x8, [x7]

    cmp x8, #5
    bge fin_guardar

    add x8, x8, #1
    str x8, [x7]

fin_guardar:
    ret
