; This file contains all of the colour palettes used in the game
; All constant assignments are substituted in place by the CA65 assembler when used later on

; Each colour corresponds to an index into the NES system Colour Palette (look at NES doc found in sources)
; There are only 64 possible hours, with a lot of them being duplicates
.segment "CODE"
BLUE = $02
RED = $05
GREEN = $19

all_palettes:   ; each palette has 16 entries, so total 32 (both background and sprite palettes)
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



; 512 bytes of background data
NAME_TABLE:	
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$03,$04,$05,$00,$00,$00,$00,$00,$00,$00,$06,$07,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$08,$09,$0a,$0b,$0b,$0b,$0c,$0d,$0e,$0f,$10,$11,$56,$13,$14,$0b,$15,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$16,$17,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$18,$19,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$1a,$1b,$1c,$1d,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$1e,$06,$1f,$00,$00,$00,$00,$00
	.byte $00,$00,$20,$21,$22,$23,$18,$24,$25,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$26,$27,$28,$00,$29,$2a,$00,$00,$00,$00,$00
	.byte $00,$00,$2b,$2c,$2d,$0b,$11,$2e,$2f,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$30,$31,$32,$33,$34,$35,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$36,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$18,$37,$38,$39,$3a,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$3b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$0b,$3c,$3d,$3e,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$3f,$40,$0b,$0b,$0b,$41,$42,$43,$44,$0b,$0b,$45,$0b,$0b,$0b,$0b,$46,$47,$48,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$49,$0b,$0b,$4a,$4b,$00,$4c,$4d,$0b,$4e,$4f,$50,$0b,$0b,$51,$00,$52,$53,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$3f,$54,$55,$12,$00,$00,$00,$57,$58,$59,$00,$5a,$5b,$5c,$5d,$00,$5e,$5f,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$60,$61,$00,$00,$62,$63,$64,$65,$00,$66,$67,$68,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$69,$00,$00,$6a,$6b,$6c,$00,$6d,$6e,$6f,$70,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$71,$72,$73,$0b,$74,$75,$76,$77,$78,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$79,$7a,$7b,$7c,$7d,$7e,$7f,$80,$81,$82,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$4c,$83,$84,$85,$86,$35,$87,$00,$00,$00,$00,$00,$00
