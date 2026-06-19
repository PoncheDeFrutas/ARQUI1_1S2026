.global _start

_start:
    mov x0, #15     // numero a sacar raiz
    mov x1, #1      // iterador

loop:
    mul x2, x1, x1  // x2 = x1 * x1
    // realizar comparacion para
    // saber si ya nos pasamos
    cmp x2, x0      // x2 > x0
    bgt end_loop

    add x1, x1, #1

    b loop

end_loop:
    // el add anterior siempre
    // nos va a dejar una posicion
    // arriba del resultado,
    // es por eso que tenemos que restar
    sub x1, x1, #1  // restamos uno
    mov x0, x1      // resultado
    mov x8, #93     // syscall exit
    svc #0
