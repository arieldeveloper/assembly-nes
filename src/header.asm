; This file contains all of the header information that classifies this file as a NES rom
.segment "HEADER" 
  .byte 'N', 'E', 'S', $1A             ; standard start to .nes file
  .byte 2                              ; PRG size (16k units)
  .byte 1                              ; CHR size, only using a 8k file
  .byte %00000001                      ; vertical mirroring (change bit 0 to 0 if horizontal)
  .byte %00000000                      ; using mapper 0 (NROM)
  .byte $0                             ; number of 8kb RAM banks
  .byte $0, $0, $0, $0, $0, $0, $0     ; rest unused, 7 bytes as shown in NES docs
