.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

main:
  lda #1
  inc
  sta $1000
  rts
