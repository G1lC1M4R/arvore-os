MEMORY {
    FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 2048K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
}

SECTIONS {
   .boot : {
        KEEP(*(.boot*))
    } > FLASH

   .text : {
        *(.text*)
    } > FLASH

    _sidata = LOADADDR(.data);

   .data : {
        _sdata =.;
        *(.data*)
        _edata =.;
    } > RAM AT > FLASH

   .bss : {
        _sbss =.;
        *(.bss*)
        _ebss =.;
    } > RAM
}
