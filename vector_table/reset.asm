.include "../utils.asm"
.include "../graphics/colour_palette.asm"
.include "../graphics/sprites.asm"

.segment "CODE"

; clears the entire OAM and initalizes with 0
; this means sprites will be initalized to y/x positions of 0 (top left corner of screen)
clr_memory:   ; routine to clear our RAM ($0000 - $07FF)
    LDA #$00  ; load A with 0
    LDX #$00  ; make sure x is also 0
    
clr_loop:
    ; store A + X into each location
    STA $0000, X
    STA $0100, X
    STA $0200, X
    STA $0300, X
    STA $0400, X
    STA $0500, X
    STA $0600, X
    STA $0700, X

    INX             ; increase x, since it's an 8bit register, it will wrap back to 0
    CPX #$00
    BNE clr_loop    ; if status register does not show zero flag, go back to top of loop
    RTS             


; In the reset handler we turn off ppu functions, set up ram, load palettes, sprites, 
; then turn PPU back on and head to the main loop 
.proc reset_handler
    SEI         ; ignore IRQs
    CLD         ; turn off decimal mode flag in P register (just for good practice)
    
    ; TODO: turn off audio (APU) / DMC IRQ's when audio added

    ; turn off the rendering to screen and NMI interrupts 
    ; Both of these registers hold many bit flags that turn on / off things in the PPU
    LDX #$00    ; load x with immediate value 0

    STX $2000   ; store x (0) to PPU control register
    STX $2001   ; store x (0) to the PPU mask register

    ; initialize the stack pointer at 255 since it grows downwards
    LDX #$FF
    TXS                 ; transfer x to stack pointer register

    ; ------------------------ GRAPHICS ---------------------------------
    
    JSR waitVBlank

    ; need to wait for PPU to stabilize so setup RAM, audio etc.
    JSR clr_memory
    JSR waitVBlank

    ; Show DMA where sprites are stored
    ; fill entire sprite memory ($0200-$02FF) using DMA at $4014
    LDA #$020  ; write the high byte only
    STA $4014  ; DMA will read 256 bytes starting at the address given
    NOP        ; delay a clock cycle for DMA to finish

    JSR load_all_palettes
    JSR load_sprites

    ; ---------------------- RE-ENABLE GRAPHICS/SOUND --------------------- 
    CLI                 ; re-enable IRQ's (opposite of first SEI instruction)

    LDA #%10010000      ; bit 7 = turn on nmi upon vblank, bit 4 for using pattern table in $1000
    STA $2000

    LDA #%00011110      ;  bit 4 = sprites on, bit 3 = display background, bit 2 = show sprites, bit 1 = show background (don't clip)
    STA $2001

    ; LOOPTEMP:
    ;    JMP LOOPTEMP

.endproc