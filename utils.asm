.segment "CODE"

.proc waitVBlank
    BIT $2002   ; checks 
    BPL  :-
.endproc