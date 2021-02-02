.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; Zero Page
SAUCE_PTR = $30
; Kernal
CHROUT = $FFD2
; PETSCII
NEWLINE = $0D

  jmp start

sauce: .byte $A1

start:
  ldx #<sauce
  stx SAUCE_PTR
  ldy #>sauce
  sty SAUCE_PTR+1
  lda (SAUCE_PTR)
  jsr print_hex ; A1
  ldx #NEWLINE
  txa
  jsr CHROUT  ; NEWLINE

  stz sauce
  ldy sauce
  tya
  jsr print_hex ; 00
  txa
  jsr CHROUT  ; NEWLINE

  phy ; 0
  plp
  php
  pla
  jsr print_hex   ; 30
  txa
  jsr CHROUT  ; NEWLINE

  sed
  php
  cld
  pla
  jsr print_hex ; 38
  txa
  jsr CHROUT  ; NEWLINE

  sei
  php
  cli
  pla
  jsr print_hex ; 34
  txa
  jsr CHROUT  ; NEWLINE

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

