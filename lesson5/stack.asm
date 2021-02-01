.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

CHROUT = $FFD2
NEWLINE = $0D
SPACE = $20

  jmp start

header: .asciiz " a  x  y sp sr"

start:
  ldx #0
@header_loop:
  lda header,x
  beq @header_done
  jsr CHROUT
  inx
  bra @header_loop
@header_done:
  lda #NEWLINE
  jsr CHROUT

  ; The main part of the program
  jsr print_regs
  lda #$12
  ldx #$34
  ldy #$56
  jsr print_regs
  pha
  jsr print_regs
  tsx
  jsr print_regs
  php
  jsr print_regs
  ply
  jsr print_regs
  plp
  jsr print_regs
  rts

print_regs:
  ; Push everything to the stack to save it while we work
  php
  pha
  phx
  php

  jsr print_hex ; a register
  lda #SPACE
  jsr CHROUT
  txa
  jsr print_hex ; x register
  lda #SPACE
  jsr CHROUT
  tya
  jsr print_hex ; y register
  lda #SPACE
  jsr CHROUT
  tsx
  txa
  clc
  adc #6  ; calculate SP from before SR
  jsr print_hex ; SP stack pointer
  lda #SPACE
  jsr CHROUT
  pla ; Pull earlier P from stack into A
  jsr print_hex ; SR status register
  lda #NEWLINE
  jsr CHROUT

  plx
  pla
  plp
  rts

print_hex:
  pha           ; push original A to stack
  lsr
  lsr
  lsr
  lsr           ; A = A >> 4
  jsr print_hex_digit
  pla           ; pull original A back from stack
  and #$0F      ; A = A & 0b00001111
  jsr print_hex_digit
  rts

print_hex_digit:
  cmp #$A
  bpl @letter
  ora #$30      ; PETSCII numbers: 1=$31
  bra @print
@letter:
  clc
  adc #$37      ; PETSCII letters: A=$41
@print:
  jsr CHROUT
  rts
