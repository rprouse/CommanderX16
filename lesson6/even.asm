.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

CHRIN = $FFCF
CHROUT = $FFD2
NEWLINE = $0D
SPACE = $20

  jmp start

yes: .byte "y"
no: .byte "n"
input: .byte 0

start:

iseven:
  jsr CHRIN
  sta input
  lda #$01

  bit input

  beq @even
  lda no
  bra @print
@even:
  lda yes
@print:
  jsr CHROUT
  rts
