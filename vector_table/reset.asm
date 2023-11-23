.import waitVBlank from "../utils.asm"

.segment "CODE"


clr_memory:   ; routine to clear our RAM ($0000 - $07FF)
    LDA #$00  ; load A with 0
    TAX       ; make sure x is also 0
    
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
    BNE clr_memory  ; if status register does not show zero flag, go back to top of loop
    RTS             ; return back from subroutine


; In the reset handler we turn off ppu functions, set up ram, load palettes, sprites, 
; then turn PPU back on and head to the main loop 
.proc reset_handler
    SEI         ; disable IRQs
    CLD         ; turn off decimal mode flag in P register (just for good practice)

    ; turn off the rendering to screen and NMI interrupts 
    ; Both of these registers hold many bit flags that turn on / off things in the PPU
    LDX #$00    ; load x with immediate value 0

    STX $2000   ; store x (0) to PPU control register
    STX $2001   ; store x (0) to the PPU mask register

    ; initialize the stack pointer
    ; since stacks grow downwards, set it to 255 (FF)
    LDX #$FF
    TXS         ; transfer x to stack pointer register

    ; ------------------------ GRAPHICS ---------------------------------

    ; wait for vblank before and after clearing the memory
    JSR waitVBlank
    JSR clr_memory

    JSR waitVBlank

    CLI             ; re-enable IRQ's (opposite of first SEI instruction)

    LDA #$10010000  ; bit 7 = turn on nmi upon vblank, bit 4 for using pattern table in $1000
    STA $2000

    LDA #$00011110   ;  bit 4 = sprites on, bit 3 = display background, bit 2 = show sprites, bit 1 = show background (don't clip)
    STA $2001

    ; infinite loop until we can get a real game loop
    LOOPTEMP:
        JMP LOOPTEMP

.endproc