; This header file contains all of the colour palettes used in the game
; All constant assignments are substituted in place by the CA65 assembler when used later on

; Each colour corresponds to an index into the NES system Colour Palette (look at NES doc found in sources)
; There are only 64 possible colours, with a lot of them being duplicates
BLUE = $02
RED = $05
GREEN = $19

.segment "RODATA"
background_palettes:
    .byte RED,BLUE,GREEN,$37 ; bg0 purple/pink
    .byte RED,$09,$19,$29 ; bg1 green
    .byte RED,$01,$11,$21 ; bg2 blue
    .byte RED,$00,$10,$30 ; bg3 greyscale

sprite_palettes:
    .byte $0F, BLUE, RED, $37 ; sp0 yellow
    .byte $0F,$14,$24,$34 ; sp1 purple
    .byte $0F,$1B,$2B,$3B ; sp2 teal
    .byte $0F,$12,$22,$32 ; sp3 marine