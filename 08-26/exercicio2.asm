PROCESSOR 16F628A
#include <p16f628a.inc>

__CONFIG _CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

ORG 0x000
movlw 0x07
movwf CMCON
banksel TRISA
clrf TRISA

main:
    banksel PORTA
    bsf PORTA, 1    ; acende o LED ligado em RA1
    call delay_omic ; chama a funçao delay_omic
    bcf PORTA, 1    ; apaga o LED ligado em RA1
    call delay_omic ; chama a funçao delay_omic
    goto main

delay_omic:
    movlw 0xFF
    movwf 0x20
    movwf 0x21
delay_loop:
    nop
    nop
    nop
    nop
    nop
    nop
    decf 0x20
    bnz delay_loop
    decf 0x21
    bnz delay_loop
    end
