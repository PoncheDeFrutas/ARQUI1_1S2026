/* =========================================================
 * Leccion 99 - Test GUI minima en ARM64 (Raspberry Pi OS)
 * Archivo: main.s
 *
 * Ensamblador: as
 * Enlazador : gcc -lX11
 * Ejecucion : host ARM64 con entorno grafico (X11/XWayland)
 *
 * Este ejemplo esta escrito en ensamblador ARM64 puro para la
 * logica de la aplicacion; usa Xlib para abrir una ventana y
 * dibujar texto.
 * ========================================================= */

/* ---------------------------------------------------------
 * Registros usados en este archivo
 * ---------------------------------------------------------
 * x19 = Display* (conexion al servidor X)
 * x20 = Window principal
 * x21 = GC (graphics context por defecto)
 * w22 = screen id por defecto
 * x29 = frame pointer
 * x30 = link register
 * --------------------------------------------------------- */

/* ---------------------------------------------------------
 * Seccion de datos
 * --------------------------------------------------------- */
.section .rodata

window_title:
    .asciz "ARM64v8 - Ventana minima"

hello_text:
    .ascii "Hola desde ARM64 ensamblador"
    hello_text_len = . - hello_text

/* ---------------------------------------------------------
 * Seccion de codigo
 * --------------------------------------------------------- */
.section .text
.global main

.extern XOpenDisplay
.extern XDefaultScreen
.extern XRootWindow
.extern XBlackPixel
.extern XWhitePixel
.extern XCreateSimpleWindow
.extern XDefaultGC
.extern XStoreName
.extern XSelectInput
.extern XMapWindow
.extern XNextEvent
.extern XDrawString
.extern XFlush
.extern XDestroyWindow
.extern XCloseDisplay

main:
    stp     x29, x30, [sp, -16]!
    mov     x29, sp
    stp     x19, x20, [sp, -16]!
    stp     x21, x22, [sp, -16]!
    sub     sp, sp, #272          // 16 bytes args + 256 bytes locales

    // display = XOpenDisplay(NULL)
    mov     x0, xzr
    bl      XOpenDisplay
    mov     x19, x0
    cbz     x19, error_return

    // screen = XDefaultScreen(display)
    mov     x0, x19
    bl      XDefaultScreen
    mov     w22, w0

    // root = XRootWindow(display, screen)
    mov     x0, x19
    sxtw    x1, w22
    bl      XRootWindow
    str     x0, [sp, #8]          // guarda root temporal

    // background = XWhitePixel(display, screen)
    mov     x0, x19
    sxtw    x1, w22
    bl      XWhitePixel
    str     x0, [sp]              // 9no argumento: background pixel

    // border = XBlackPixel(display, screen)
    mov     x0, x19
    sxtw    x1, w22
    bl      XBlackPixel
    mov     x7, x0                // 8vo argumento: border pixel

    // win = XCreateSimpleWindow(display, root, x, y, w, h, border_width, border, background)
    ldr     x1, [sp, #8]          // root window
    mov     x0, x19
    mov     x2, #220              // x
    mov     x3, #140              // y
    mov     x4, #640              // width
    mov     x5, #220              // height
    mov     x6, #1                // border width
    bl      XCreateSimpleWindow
    mov     x20, x0

    // gc = XDefaultGC(display, screen)
    mov     x0, x19
    sxtw    x1, w22
    bl      XDefaultGC
    mov     x21, x0

    // XStoreName(display, win, title)
    mov     x0, x19
    mov     x1, x20
    adr     x2, window_title
    bl      XStoreName

    // XSelectInput(display, win, ExposureMask | KeyPressMask | StructureNotifyMask)
    mov     x0, x19
    mov     x1, x20
    movz    x2, #0x8001
    movk    x2, #0x2, lsl #16
    bl      XSelectInput

    // XMapWindow(display, win)
    mov     x0, x19
    mov     x1, x20
    bl      XMapWindow

    // Asegura envio de peticiones al servidor grafico
    mov     x0, x19
    bl      XFlush

event_loop:
    // XNextEvent(display, &event)
    mov     x0, x19
    add     x1, sp, #16
    bl      XNextEvent

    // event.type (offset 0)
    ldr     w0, [sp, #16]
    cmp     w0, #12               // Expose
    b.eq    draw_text
    cmp     w0, #2                // KeyPress
    b.eq    close_app
    cmp     w0, #17               // DestroyNotify
    b.eq    close_app
    b       event_loop

draw_text:
    // XDrawString(display, win, gc, x, y, msg, len)
    mov     x0, x19
    mov     x1, x20
    mov     x2, x21
    mov     x3, #24
    mov     x4, #80
    adr     x5, hello_text
    mov     x6, hello_text_len
    bl      XDrawString

    mov     x0, x19
    bl      XFlush
    b       event_loop

close_app:
    mov     x0, x19
    mov     x1, x20
    bl      XDestroyWindow

    mov     x0, x19
    bl      XCloseDisplay

    mov     w0, #0
    b       finish

error_return:
    mov     w0, #1

finish:
    add     sp, sp, #272
    ldp     x21, x22, [sp], #16
    ldp     x19, x20, [sp], #16
    ldp     x29, x30, [sp], #16
    ret
