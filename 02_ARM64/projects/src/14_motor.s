.data

newline:
    .ascii "\n"

err_input:
    .ascii "ERROR\n"
    len_err_input = . - err_input

.bss

buffer:
    .skip 64

num_buffer:
    .skip 32

// definir los valores ideales
// definiendo los arreglos para cada sensor (5 datos)

.text
.global _start
.include "10_atoi_num.s"

_start:
    // deben implementar todas sus varibles necesarias
    // pueden ser las contantes
    mov x5, #10

main_loop:
    // read(0, buffer, 64)
    mov x0, #0         // stdin
    ldr x1, =buffer    // buffer
    mov x2, #64        // size
    mov x8, #63        // read
    svc #0

    // verifcacion de error
    cmp x0, #0
    beq exit_ok
    ble exit_error

    ldr x21, =buffer

    //12,45,78,89,45,56
    ldrb w0, [x21]
    cmp w0, 'n'
    beq exit_ok

    bl atoi_csv

    cbz x7, print_error

    mov x24, x10     // el primer numero (temperatura)

    bl atoi_csv

    cbz x7, print_error

    // suma de los 2 valores = 20,10 => 20+10 = 30
    add x0, x24, x10

    bl print_uint

    // write
    mov x0, #1
    ldr x1, =newline
    mov x2, #1
    mov x8, #64
    svc #0

    b main_loop


print_error:
    // write(1, err_input, len_err_input)
    mov x0, #1         // stdout
    ldr x1, =err_input  // err_input
    mov x2, #len_err_input // length of err_input
    mov x8, #64        // write
    svc #0
    b main_loop


exit_ok:
    mov x0, #0         // 0
    mov x8, #93        // exit
    svc #0

exit_error:
    mov x1, #1         // stdout
    mov x8, #93        // exit
    svc #0

//                                                                  [2][3][\0]
print_uint:
    ldr x1, =num_buffer
    add x1, x1, #31

    mov w2, #0
    strb w2, [x1]

    mov x3, #10
    mov x4, #0

    cmp x0, #0
    bne convert_loop

    sub x1, x1, #1
    mov w2, '0'
    strb w2, [x1]
    mov x4, #1
    b write_number

convert_loop:
    // 123
    // 123 / 10 = 12
    // msub = 123 - (12 * 10) = 3
    udiv x9, x0, x3
    msub x6, x9, x3, x0

    add x6, x6, '0'

    sub x1, x1, #1
    strb w6, [x1]

    add x4, x4, #1

    mov x0, x9
    cbnz x0, convert_loop

write_number:
    mov x0, #1
    mov x2, x4
    mov x8, #64
    svc #0

    ret
