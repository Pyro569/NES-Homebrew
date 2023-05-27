; 16 byte header

  .inesprg 1                      
  .ineschr 1                      
  .inesmap 0                      
  .inesmir 1                      

    .bank 0                      
    .org $C000                    


RESET: 
    SEI 
    CLD      

LoadPalettes:
    LDA $2002
    LDA #$3F
    STA $2006
    LDA #$00
    STA $2006

    LDX #$00

LoadPalettesLoop:
    LDA PaletteData, x
    STA $2007
    INX
    CPX #$20
    BNE LoadPalettesLoop

    LDA #$80
    STA $0200
    STA $0203
    LDA #$00
    STA $0201
    STA $0202

    LDA #%10000000
    STA $2000

    LDA #%10010000 
    STA $2001

Forever:
    JMP Forever

NMI:
    LDA #$00
    STA $2003
    LDA #$02
    STA $4014

    RTI

    .bank 1 
    .org $E000

PaletteData:
    .db $0F, $31, $32, $33, $0F, $35, $36, $37, $0F, $39, $3A, $3B, $0F, $3D, $3E, $0F
    .db $0F, $1C, $15, $14, $0F, $02, $38, $3C, $0F, $1C, $15, $14, $0F, $02, $38, $3C 

    .org $FFFA
    .dw NMI
    .dw RESET
    .dw 0

    .bank 2
    .org $0000