ENTRY(_start)

SECTIONS
{
   . = 0x10000000;
   .boot : { *(.boot) }
   .text : { *(.text*) }
   .rodata : { *(.rodata*) }
   .data : { *(.data*) }
   .bss : { *(.bss*) *(COMMON) }
}
