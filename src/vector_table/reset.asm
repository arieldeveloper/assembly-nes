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

    LDX #$00

    ; load all sprites for starting configuration
    loadAllSpritesOAM:
        LDA adev, x 
        STA $0200, x    ; for a sprite with 4 tiles, this loads into 2000/1/2/3 
        INX
        CPX #$10        ; load all 4 sprites (4 bytes each)
        BNE loadAllSpritesOAM

    ; Load background, goes at $2000 in the PPU
    LDA $2002
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006
    LDX #$00

        ; Set initial scroll position
    LDA #$00   ; vertical scroll to 0
    STA $2005
    LDA #$00   ; horizontal scroll to 0
    STA $2005

    ; load the first 256 bytes of background
    loadStartBackground:
        LDA startBackground, x
        STA $2007
        INX
        CPX #$00                 ; loop 256 bytes
        BNE loadStartBackground  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero

    loadStartBackground2:
        LDA startBackground + 256, x
        STA $2007
        INX
        CPX #$00                 ; loop 256 bytes
        BNE loadStartBackground2  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero

    loadStartBackground3:
        LDA startBackground + 512, x
        STA $2007
        INX
        CPX #$00                 
        BNE loadStartBackground3

    loadStartBackground4:
        LDA startBackground + 768, x
        STA $2007
        INX
        CPX #$C0                  ; loop 256 bytes
        BNE loadStartBackground4  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero


    ; ---------------------- RE-ENABLE GRAPHICS/SOUND --------------------- 
    ;CLI                 ; re-enable IRQ's (opposite of first SEI instruction) -- NOT WORKING --
    LDA #%10010000      ; bit 7 = nmi on vblank, bit 4 = use pattern table 1 for backgrounds, bit 3 = pattern table 0 for sprites
    STA $2000

    LDA #%00011110      ;  bit 4 = sprites on, bit 3 = display background, bit 2 = show sprites, bit 1 = show background (don't clip)
    STA $2001
    
    LDA #$00
    STA $2005
    STA $2005

    ; initialize x variable with wherever the sprite's x was for adev
    LDA $0203    ; x coordinate of adev
    STA adevX

    LOOPTEMP:
       JMP LOOPTEMP