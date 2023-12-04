.segment "CODE"

.proc waitVBlank
    BIT $2002         ; holds the PPU status flags
    BPL waitVBlank    ; if negative flag (bit 7) then we are not in vblank, so keep waiting
.endproc