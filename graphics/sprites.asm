; This file defines sprites
; sprites are defined as follows:
;                   - y coordinate of the top left - 1 (1 byte)
;                   - index number of the sprite in the pattern tables (1 byte)
;                   - attributes about the sprite (1 byte)
;                           - bit 0/1 used for colour
;                           - bit 5  = whether sprite has priority over background
;                           - bit 6 - flip horonzontally 
;                           - bit 7 - flip vertically   
;                   - x coordinate of the top left

; Sprite that displays my name
NAME_SPRITE:
    .byte $01, $0, $01, $10

load_sprites:
    RTS