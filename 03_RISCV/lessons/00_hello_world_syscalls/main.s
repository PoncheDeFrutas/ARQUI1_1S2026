/* =========================================================
 * Lección 00 – Hello World en RISC-V 64 (Linux)
 * Archivo: main.s
 *
 * Ensamblador: riscv64-linux-gnu-as
 * Enlazador : riscv64-linux-gnu-ld
 * Ejecución : qemu-riscv64
 *
 * No usa libc, solo syscalls de Linux.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * a0 = argumento 1 de syscall (fd o codigo de salida)
 * a1 = argumento 2 de syscall (direccion de buffer)
 * a2 = argumento 3 de syscall (cantidad de bytes)
 * a7 = numero de syscall Linux RISC-V
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Sección de datos
 * --------------------------------------------------------- */
.section .data

msg:
    .ascii "Hello, world\n"     # Cadena a imprimir (sin NULL)
msg_len = . - msg               # Longitud del mensaje

/* ---------------------------------------------------------
 * Sección de código
 * --------------------------------------------------------- */
.section .text
.global _start

_start:
    /* -----------------------------------------------------
     * syscall: write(stdout, msg, msg_len)
     *
     * a0 = file descriptor (1 = stdout)
     * a1 = dirección del buffer
     * a2 = número de bytes
     * a7 = número de syscall (64)
     * ----------------------------------------------------- */
    li      a0, 1               # stdout
    la      a1, msg             # dirección del mensaje
    li      a2, msg_len         # longitud
    li      a7, 64              # syscall write
    ecall                       # llamada al kernel

    /* -----------------------------------------------------
     * syscall: exit(0)
     *
     * a0 = código de salida
     * a7 = número de syscall (93)
     * ----------------------------------------------------- */
    li      a0, 0               # código de salida
    li      a7, 93              # syscall exit
    ecall                       # llamada al kernel
