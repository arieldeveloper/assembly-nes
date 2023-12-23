.segment "CODE"

.proc nmi_handler
    ; clear vblank flag by reading PPU status
    LDA $2002

    RTI
.endproc
