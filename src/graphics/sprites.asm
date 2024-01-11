; This file defines sprites
; sprites get stored in the OAM
; sprites are composed of the following (stored into 0200, 0201, 0202, 0203 respectively):
;                   - y coordinate of the top left - 1 (1 byte)
;                   - index number of the sprite in the pattern tables (1 byte)
;                   - attributes about the sprite (1 byte)
;                           - bit 0/1 used for colour
;                           - bit 5  = whether sprite has priority over background
;                           - bit 6 - flip horonzontally 
;                           - bit 7 - flip vertically   
;                   - x coordinate of the top left

.segment "CODE"
; Stores adev ($0200-$02FF)
adev: 
    .byte $91, $10, $00, $08          ; top left
    .byte $91, $11, %00000000, $10    ; top right
    .byte $99, $4F, %00000000, $08    ; bottom left
    .byte $99, $4F, %01000000, $10    ; bottom right