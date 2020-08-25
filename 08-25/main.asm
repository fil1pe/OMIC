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
    bsf PORTA, 1
    bsf PORTA, 2
    goto main
    end
