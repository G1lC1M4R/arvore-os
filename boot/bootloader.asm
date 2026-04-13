.syntax unified
.cpu cortex-m0plus
.thumb

.section.boot, "ax"
.global _start
_start:
    ldr r0, =0x20030000
    mov sp, r0
    bl main
loop:
    b loop

.section.text
.global putc
putc:
    ldr r1, =0x40034000
1: ldr r2, [r1, #0x24]
    lsls r2, r2, #26
    bmi 1b
    strb r0, [r1, #0x00]
    bx lr

.global delay
delay:
    movs r1, #100
1: subs r1, r1, #1
    bne 1b
    bx lr
