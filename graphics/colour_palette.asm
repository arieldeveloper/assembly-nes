; This file contains all of the colour palettes used in the game
; All constant assignments are substituted in place by the CA65 assembler when used later on

; Each colour corresponds to an index into the NES system Colour Palette (look at NES doc found in sources)
; There are only 64 possible hours, with a lot of them being duplicates
BLUE = $02
RED = $05
GREEN = $19

background_sprite_palettes:   ; each palette has 16 entires, so total 32 (both background and sprite palettes)
    .byte BLUE, GREEN, RED, GREEN
    .byte GREEN, GREEN, GREEN, GREEN
    .byte BLUE, BLUE, BLUE, BLUE
    .byte RED, RED, RED, RED
    ; now sprites
    .byte BLUE, GREEN, RED, GREEN
    .byte GREEN, GREEN, GREEN, GREEN
    .byte BLUE, BLUE, BLUE, BLUE
    .byte RED, RED, RED, RED

load_all_palettes:

    ; tell PPU to load into $3f00 (where image palettes start in PPU), write high byte then low byte
    LDA #$3F 
    STA $2006

    LDA #$00
    STA $2006

    LDX #$00
    ; start writing all the palletes (address $2007 for reading and writing to PPU)
    
    load_palette:
        LDA background_sprite_palettes, X
        STA $2007
        INX
        CPX #$20  ; loop 32 times
        BNE load_palette

    RTS

load_all_sprites:
    