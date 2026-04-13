; bootloader.asm - Raspberry Pi Pico RP2040
; Roda direto no chip, sem Android

.cpu cortex-m0plus
.thumb

.section.boot, "ax"
.global _start

_start:
    ; 1. Configura Stack Pointer no final da RAM
    ldr r0, =0x20042000
    mov sp, r0

    ; 2. Copia.data da FLASH pra RAM
    ldr r0, =_sidata
    ldr r1, =_sdata
    ldr r2, =_edata
    subs r2, r2, r1
    beq pular_copia
loop_copia:
    ldrb r3, [r0]
    strb r3, [r1]
    adds r0, r0, #1
    adds r1, r1, #1
    subs r2, r2, #1
    bne loop_copia
pular_copia:

    ; 3. Zera a seção.bss
    ldr r1, =_sbss
    ldr r2, =_ebss
    movs r0, #0
loop_bss:
    cmp r1, r2
    beq chamar_kernel
    strb r0, [r1]
    adds r1, r1, #1
    b loop_bss

chamar_kernel:
    ; 4. Pula pro seu kernel.c
    bl kernel_main

    ; 5. Se kernel_main retornar, trava aqui
travou:
    b travou
