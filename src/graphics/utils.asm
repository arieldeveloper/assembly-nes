; File for holding useful functions pertaining to graphics

fillNametable0:
    LDA $2002
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006
    RTS

fillNameTable1:
    LDA $2002
    LDA #$20
    STA $2006
    LDA #$00
    STA $2006
    RTS

; Function for filling in the nametable in the PPU
; Parameters: load backgroundAddr with nametable address needed
;             load X register with 0 for nametable 0, 1 for nametable 1
.macro loadBackground backgroundAddr, nameTableLow, nameTableHigh
; scope ensures that when we call this macro again, the labels don't cause a duplicate symbol error, essentially making them local only
.scope                       
    ; if parameter X is 0, set writing addr to nametable 0, otherwise set writing addr to nametable 1
    LDA $2002     ; reset latch on PPU register
    LDA nameTableLow
    STA $2006
    LDA nameTableHigh
    STA $2006
    
    LDX #$00  ; clear X register

    ; load the first 256 bytes of background
    bgLoad1:
        LDA backgroundAddr, x
        STA $2007
        INX
        CPX #$00                 ; loop 256 bytes
        BNE bgLoad1  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero

    bgLoad2:
        LDA backgroundAddr + 256, x
        STA $2007
        INX
        CPX #$00                 ; loop 256 bytes
        BNE bgLoad2  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero

    bgLoad3:
        LDA backgroundAddr + 512, x
        STA $2007
        INX
        CPX #$00                 
        BNE bgLoad3

    bgLoad4:
        LDA backgroundAddr + 768, x
        STA $2007
        INX
        CPX #$C0                  ; loop 256 bytes
        BNE bgLoad4  ; Branch to LoadBackgroundLoop if compare was Not Equal to zero
.endscope
.endmacro