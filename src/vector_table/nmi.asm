; NMI handler - triggered on vblank by PPU after each frame
; We handle most graphics drawings here
.segment "CODE"

faceAdevBackward:
    LDA #$11
    STA $0201
    LDA #%01000000
    STA $0202
    LDA #$10
    STA $0205
    LDA #%01000000
    STA $0206
    RTS

faceAdevForward:
    LDA #$10
    STA $0201
    LDA #%00000000
    STA $0202
    LDA #$11
    STA $0205
    LDA #%00000000
    STA $0206
    RTS

nmi_handler:
    LDA scrollPos
    STA $2005 ; horizontal scroll
    LDA $00  ; vertical scroll to 0
    STA $2005

    ; do a DMA transfer, all of the OAM gets put into the PPU to show sprite graphics
    LDA #$00
    STA $2003       ; set low byte of the ram address
    LDA #$02
    STA $4014       ; now set the high byte, it will transfer 

    ; Let's adjust the player coordinates based on controller
    ; First, we do a 1/0 write sequence to reload controller state into register
    ; NES docs shows a write to the 0th bit at $4016, called a strobe that goes high/low]
    LDA #$01
    STA $4016   ; high strobe, will latch the value
    LDA #$00     ; low strobe, will stop reloading
    STA $4016

    ; read all the buttons until left, right
    LDA $4016
    LDA $4016
    LDA $4016
    LDA $4016
    LDA $4016
    LDA $4016

    readLeft:
        LDA $4016
        AND #%00000001      ; only bit 0 tells us which button pressed
        BEQ readLeftDone    ; if not pressed, don't do anything, branch to check next button
        ; left was pressed
        ; move adev left
        JSR faceAdevBackward    ; turn adev sprite around
        ; LDA adevX
        ; SEC             ; make sure of carry flag is set 
        ; SBC #$01        ; move left
        ; STA $0203       ; store X into left top tile
        ; STA $020B       ; store X into left bottom tile
        ; STA adevX
        ; LDX $00
        ; TAX
        ; CLC
        ; ADC #$08            ; add 8 to X because the right tiles are 8 pixels to the right of adevX
        ; STA $0207
        ; STA $020F
        DEC scrollPos

    readLeftDone:           ; handling this button is done
        
    readRight:
        LDA $4016
        AND #%00000001          ; only bit 0 tells us which button pressed
        BEQ readRightDone       ; if not pressed, don't do anything, branch to check next button
        ; right was pressed
        JSR faceAdevForward
        ; LDA adevX
        ; CLC
        ; ADC #$01
        ; STA $0203       ; store X into left top tile
        ; STA $020B       ; store X into left bottom tile
        ; STA adevX
        ; LDX $00
        ; TAX
        ; ADC #$08        ; add 8 to X because the right tiles are 8 pixels to the right of adevX
        ; STA $0207
        ; STA $020F
        INC scrollPos

    readRightDone:
    RTI
