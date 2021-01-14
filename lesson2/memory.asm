.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

ZP_PTR_1 = $30
ZP_PTR_2 = $32
ZP_DATA  = $34

  jmp start   ; absolute

data:
  .byte $01,$23,$45,$67,$89,$AB,$CD,$EF

results:
  .byte 0,0,0

start:
  lda data        ; absolute
  sta ZP_DATA     ; zero page
  ldx #1          ; immediate
  lda data,x      ; absolute indexed with X
  sta ZP_DATA,x   ; zero page indexed with X
  txa             ; implied (transfer X to A)
  tay             ; implied (transfer A to Y)
  iny             ; implied (increment Y)
  lda data,y      ; absolute indexed with Y
  sta ZP_DATA,y   ; zero page indexed with Y

  lda #<data      ; immediate address low byte
  sta ZP_PTR_1    ; zero page
  lda #>data      ; immedidate address high byte
  sta ZP_PTR_1+1  ; zero page calculated

  lda #<(data+4)  ; immediate calulated address low byte
  sta ZP_PTR_2    ; zero page
  lda #>(data+4)  ; immedidate calculated address high byte
  sta ZP_PTR_2+1  ; zero page calculated

  lda (ZP_PTR_1)  ; zero page indirect
  sta results     ; absolute
  inx             ; implied
  lda (ZP_PTR_1,x); zero page indexed indirect
  sta results+1   ; absolute calculated
  lda (ZP_PTR_1),y; zero page indirect indexed with Y
  sta results,y   ; absolute indexed with Y

  jmp (lookup_ptr)  ; absolute indirect

lookup_ptr:
  .addr lookup

lookup:
  jmp (jmp_table,x)  ; absolute indexed indirect

jmp_table:
  .addr start,return

return:
  rts
