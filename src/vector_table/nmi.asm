.segment "CODE"

nmi_handler:
    ; do a DMA transfer, all of the OAM gets put into the PPU to show sprite graphics
    LDA #$00
    STA $2003       ; set low byte of the ram address
    LDA #$02
    STA $4014       ; now set the high byte, it will transfer 

    ; increase adev X position
    LDA adevX
    STA $0203   ; store X into left top tile
    STA $020B   ; store X into left bottom tile
    TAX
    CLC
    ADC #$08    ; add 8 to X because the right tiles are 8 pixels to the right of adevX
    STA $0207
    STA $020F
    INX         ; now we move player's X position by 1
    STA adevX
    RTI
