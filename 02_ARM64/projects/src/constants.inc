/* Shared constants for Linux AArch64. */

.equ SYS_READ,       63
.equ SYS_WRITE,      64
.equ SYS_EXIT,       93
.equ SYS_MUNMAP,     215
.equ SYS_MMAP,       222

.equ STDIN,          0
.equ STDOUT,         1
.equ STDERR,         2

.equ PROT_READ,      1
.equ PROT_WRITE,     2
.equ MAP_PRIVATE,    2
.equ MAP_ANONYMOUS,  32

.equ ERR_OK,         0
.equ ERR_INPUT,     -1
.equ ERR_RANGE,     -2
.equ ERR_ALLOC,     -3
.equ ERR_NO_SLOT,   -4
.equ ERR_NOT_FOUND, -5
.equ ERR_SINGULAR,  -6
.equ ERR_UNKNOWN,   -99

.equ INPUT_BUF_SIZE, 64
.equ OUTPUT_BUF_SIZE, 128

.equ MENU_CREATE,       1
.equ MENU_LIST,         2
.equ MENU_PRINT,        3
.equ MENU_PRINT_RESULT, 4
.equ MENU_FREE,         5
.equ MENU_FREE_ALL,     6
.equ MENU_OPS,          7
.equ MENU_EXIT,         8

.equ MAX_MATRICES,   16
.equ MAX_DIMENSION,  32
.equ MATRIX_TYPE_Q32, 1

.equ DESC_STATUS,    0
.equ DESC_ROWS,      8
.equ DESC_COLS,      16
.equ DESC_ELEMS,     24
.equ DESC_BYTES,     32
.equ DESC_DATA,      40
.equ DESC_TYPE,      48
.equ DESC_LABEL,     56
.equ MATRIX_DESC_SIZE, 64

.equ MATRIX_STATUS_FREE,   0
.equ MATRIX_STATUS_ACTIVE, 1
