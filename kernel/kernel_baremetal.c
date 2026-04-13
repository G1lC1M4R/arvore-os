void putc(char c);
void delay(void);

void print(const char *s) {
    while (*s) putc(*s++);
}

void main(void) {
    volatile unsigned int *SIO = (unsigned int *)0xD0000000;
    volatile unsigned int *RESETS = (unsigned int *)0x4000C000;
    volatile unsigned int *IO_BANK0 = (unsigned int *)0x40014000;

    RESETS[4] &= ~(1 << 5);
    while ((RESETS[2] & (1 << 5)) == 0);

    IO_BANK0[32] = 5;
    SIO[9] = (1 << 25);

    print("\n=== ARVORE OS BOOT REAL ===\n");
    print("Adalina no controle do Raspberry Pi Pico!\n");
    print("Bootloader funcionou!\n\n");

    while (1) {
        SIO[6] = (1 << 25);
        print("LED ON\n");
        for (int i = 0; i < 500000; i++) delay();

        SIO[7] = (1 << 25);
        print("LED OFF\n");
        for (int i = 0; i < 500000; i++) delay();
    }
}
