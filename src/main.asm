; This file contains all of the header information that classifies this file as a NES rom
.include "header.asm"

.segment "ZEROPAGE"
adevX:
    .res  1   ; reserve 1 byte for adev x
adevY:
    .res  1   ; reserve 1 byte for adev y

.include "./graphics/colour_palette.asm"
.include "./graphics/background.asm"
.include "./graphics/sprites.asm"

.include "./vector_table/nmi.asm"
.include "./vector_table/irq.asm"
.include "./vector_table/reset.asm"

.segment "CODE"

waitVBlank:
    BIT $2002         ; hold PPU status flags, specifically negative flag (bit 7)
    BPL waitVBlank    ; if negative flag, we are still in vblank so keep waiting
    RTS

.segment "VECTORTABLE"
.addr nmi_handler  ;  Non-Maskable Interrupt (hardware interrupt, can't manipulate), at $FFFA and $FFFB
.addr reset_handler ; reset handler at $FFFC and $FFFD
.addr irq_handler  ; Interrupt request (can manipulate), at $FFFE and $FFFF

; Include the CHR file into catridge ROM
.segment "CHRFILE"
.incbin "adev.chr"

.segment "OAM"
