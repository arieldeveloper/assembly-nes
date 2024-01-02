.segment "CODE"

nmi_handler:
    ; do a DMA transfer, all of the OAM gets put into the PPU to show sprite graphics
    LDA #$00
    STA $2003       ; set low byte of the ram address
    LDA #$02
    STA $4014       ; now set the high byte, it will transfer 

    ; increase adev X position
    ; LDA adevX
    ; STA $0203   ; store X into left top tile
    ; STA $020B   ; store X into left bottom tile
    ; TAX
    ; CLC
    ; ADC #$08    ; add 8 to X because the right tiles are 8 pixels to the right of adevX
    ; STA $0207
    ; STA $020F
    ; INX         ; now we move player's X position by 1
    ; STA adevX

    ; Let's adjust the player coordinates based on controller
    ; First, we do a 1/0 write sequence to reload controller state into register
    ; NES docs shows a write to the 0th bit at $4016, called a strobe that goes high/low]
    LDA $01
    STA $4006   ; high strobe, will latch the value
    LDA $00     ; low strobe, will stop reloading
    STA $4006

    ; read all the buttons until left, right
    LDX $00
    loopShiftController:
        LDA $4016
        CPX $06
        BEQ readLeft

    readLeft: 
        LDA $4016
        AND #%00000001  ; only bit 0 tells us which button pressed
        BEQ readLeftDone   ; if not pressed, don't do anything, branch to check next button
        ; left was pressed
        ; move adev left

    readLeftDone:        ; handling this button is done
        
    readRight:
        LDA $4016
        AND #%00000001  ; only bit 0 tells us which button pressed
        BEQ readRightDone   ; if not pressed, don't do anything, branch to check next button
        ; right was pressed

        ; move adev left

    readRightDone:  
    ; Draws adev

    RTI
