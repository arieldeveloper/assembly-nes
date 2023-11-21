; This file contains all of the header information that classifies this file as a NES rom
.segment "HEADER" 

; this header is to set up a NROM mapper 000 with fixed banks (no bank switching)
  .byte 'N', 'E', 'S', $1A            ; these bytes always start off an ines file
  .byte $02                           ; PRG size (16k units)
  .byte $01                           ; CHR size (8k units)
  .byte $00                           ; using mapper 0 (NROM)
  .byte $00                           ; RAM pages used (8k units)
  ; .byte $0, $0, $0, $0, $0, $0, $0    ; filled by the assembler due to fill argument in config file

  