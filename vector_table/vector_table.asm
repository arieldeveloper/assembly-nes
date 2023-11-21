; This file puts the nmi, reset, irq handler addresses from our code into 
; their respective locations as shown in the nes memory layout.
; .word and .addr defines a 16-bit address of the handler into the two 8 bit chunks of memory

.include "nmi.asm"
.include "reset.asm"
.include "irq.asm"

.segment "VECTOR_TABLE"

; Non-Maskable Interrupt (hardware interrupt, can't manipulate), at $FFFA and $FFFB
.addr nmi_handler  

; at $FFFC and $FFFD
.addr reset_handler

; Interrupt request (can manipulate), at $FFFE and $FFFF
.addr irq_handler
