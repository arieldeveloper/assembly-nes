; This file contains all of the header information that classifies this file as a NES rom
.include "header.asm"
.include "./graphics/colour_palette.asm"
.include "./graphics/sprites.asm"

.include "./vector_table/nmi.asm"
.include "./vector_table/irq.asm"

.segment "CODE"

waitVBlank:
    BIT $2002         ; hold PPU status flags, specifically negative flag (bit 7)
    BPL waitVBlank    ; if negative flag, we are still in vblank so keep waiting
    RTS

; In the reset handler we turn off ppu functions, set up ram, load palettes, sprites, 
; then turn PPU back on
reset_handler:
    SEI         ; ignore IRQs
    CLD         ; turn off decimal mode flag in P register (just for good practice)

    ; turn off the rendering to screen and NMI interrupts 
    ; Both of these registers hold many bit flags that turn on / off things in the PPU
    LDX #$00    ; load x with immediate value 0

    STX $2000   ; disable NMI through PPU control register
    STX $2001   ; disable rendering through PPU mask register
    STX $4010   ; disable DMC IRQ (pertains to APU, sound)

    ; ------------------------ GRAPHICS --------------------------------
    JSR waitVBlank
    LDX #$00

    ; clear all memory, including stack, make sure not to do this in a subroutine
    clr_memory: 
        LDA #$00
        STA $0000, x
        STA $0100, x   ; clears the stack
        STA $0300, x
        STA $0400, x
        STA $0500, x
        STA $0600, x
        STA $0700, x
        ; set up OAM memory with FE instead of 0
        LDA #$FF
        STA $0200, x
        INX
        BNE clr_memory
    
    ; initialize the stack pointer at 255 (since it grows downwards)
    LDX #$FF            
    TXS                 ; transfer x to stack pointer register
        
    JSR waitVBlank

    ;load palettes and sprites
    load_bg_palettes:
        LDA $2002  ; resets high/low latch so when we write to $2006, it's high first

        ; tell PPU to load into $3f00 (where image palettes start in PPU)
        LDA #$3F
        STA $2006  ; write high byte
        LDA #$00
        STA $2006 ; write low byte

        LDX #$00

        load_bg_palette:
            LDA background_palettes, X
            STA $2007   ; loads palette into PPU, starting at 3F00, increases address automatically after
            INX
            CPX #$10    ; loops over 16 bytes, 4 palettes (for background)
            BNE load_bg_palette

    LDX #$00

    load_sprite_palettes:
        LDA sprite_palettes, X
        STA $2007
        INX 
        CPX #$10 
        BNE load_sprite_palettes

    ; ---------------------- RE-ENABLE GRAPHICS/SOUND --------------------- 
    ;CLI                 ; re-enable IRQ's (opposite of first SEI instruction)

    LDA #%10000000      ; bit 7 = nmi on vblank, bit 4 for using pattern table 0
    STA $2000

    LDA #%00011110      ;  bit 4 = sprites on, bit 3 = display background, bit 2 = show sprites, bit 1 = show background (don't clip)
    STA $2001

    ; not the main loop
    LOOPTEMP:
       JMP LOOPTEMP


.segment "VECTORTABLE"
.addr nmi_handler  ;  Non-Maskable Interrupt (hardware interrupt, can't manipulate), at $FFFA and $FFFB
.addr reset_handler ; reset handler at $FFFC and $FFFD
.addr irq_handler  ; Interrupt request (can manipulate), at $FFFE and $FFFF

; Include the CHR file into catridge ROM
.segment "CHRFILE"
.incbin "mario.chr"

.segment "OAM"
