.segment "CODE"

nmi_handler:
    LDA #$00
    STA $2003       ; set low byte of the ram address
    LDA #$02
    STA $4014       ; now set the high byte, it will transfer 

    ; Draws adev
    JSR DrawAdev
    RTI
