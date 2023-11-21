.segment "CODE"

.proc reset_handler
    SEI     ; disable IRQs
    CLD     ; turn off decimal mdoe flag in P register (just for good practice)

    LDX #$00  ; load x with immediate value 0

    ; turn off the rendering to screen and NMI interrupts 
    ; Both of these registers hold many bit flags that turn on / off things in the PPU
    STX $2000   ; store x (0) to PPU control register
    STX $2001   ; store x (0) to the PPU mask register

.endproc
