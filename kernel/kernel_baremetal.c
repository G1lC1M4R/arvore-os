// kernel/kernel_baremetal.c - Versão pra rodar no Pico
#define UART0_BASE 0x40034000
#define UART0_DR (*(volatile unsigned int*)(UART0_BASE + 0x00))
#define UART0_FR (*(volatile unsigned int*)(UART0_BASE + 0x18))

void uart_putc(char c) {
    while (UART0_FR & (1 << 5)); // Espera TX vazio
    UART0_DR = c;
}

void uart_puts(const char* s) {
    while (*s) uart_putc(*s++);
}

void kernel_main(void) {
    // Configuração mínima da UART0
    *(volatile unsigned int*)0x40034024 = 833; // Baud 115200
    *(volatile unsigned int*)0x4003402C = 0x70;

    uart_puts("\n\r=== ARVORE OS BOOT REAL ===\n\r");
    uart_puts("Adalina no controle do Raspberry Pi Pico!\n\r");
    uart_puts("Bootloader funcionou!\n\r");

    while(1) {
        // Pisca LED onboard
        *(volatile unsigned int*)0x40014014 = 1 << 25; // GPIO25 ON
        for(volatile int i=0; i<1000000; i++);
        *(volatile unsigned int*)0x40014018 = 1 << 25; // GPIO25 OFF
        for(volatile int i=0; i<1000000; i++);
    }
}
