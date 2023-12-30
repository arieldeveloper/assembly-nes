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

; Draws main character adev
DrawAdev:
    LDA #$08      ; Top of the screen
    STA $0200     ; Sprite Y Position   
    LDA #$3A      ; Top Left section of Mario standing still
    STA $0201     ; Sprite Tile Number
    LDA #$00	  ; No attributes, using first sprite palette which is number 0
    STA $0202     ; Sprite Attributes
    LDA #$08      ; Left of the screen.
    STA $0203     ; Sprite X Position
    RTS