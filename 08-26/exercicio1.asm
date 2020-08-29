PROCESSOR 16F628A
#include <p16f628a.inc>

__CONFIG _CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

ORG 0x000
movlw 0x07
movwf CMCON
banksel TRISA
clrf TRISA
clrf TRISB
bsf TRISB, 3

main:
    banksel PORTA
    btfsc PORTB, 3
    goto senao	    ; vai para senao se a entrada em RB3 for 1
    bsf PORTA, 1    ; acende o LED ligado em RA1
    bcf PORTA, 2    ; apaga o LED ligado em RA2
    goto fimse
senao:
    bcf PORTA, 1    ; apaga o LED ligado em RA1
    bsf PORTA, 2    ; acende o LED ligado em RA2
fimse:
    goto main
    end
