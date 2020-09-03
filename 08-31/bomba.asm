PROCESSOR 16F628A
#include <p16f628a.inc>

__CONFIG _CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

ORG 0x000
movlw 0x07
movwf CMCON
banksel TRISA
clrf TRISA
clrf TRISB

banksel PORTA

main:
    movlw 9
    movwf 0x22	    ; inicializa 0x22 com 9
loop:
    movfw 0x22
    call display
    call delay_omic ; mostra o valor em 0x22 e espera
    decf 0x22	    ; decrementa o valor em 0x22
    bz loop_end	    ; se o valor for zero, vai para loop_end
    goto loop
loop_end:	    ; mostra 0
    movwf 0
    call display
    call delay_omic
    goto main

;	RA7	
;RA0		RA6
;	RA1	
;RA2		RB0
;	RA3	

display:
    banksel PORTA
    addlw 1
    movwf 0x20
    
    decf 0x20
    bz display0
    decf 0x20
    bz display1
    decf 0x20
    bz display2
    decf 0x20
    bz display3
    decf 0x20
    bz display4
    decf 0x20
    bz display5
    decf 0x20
    bz display6
    decf 0x20
    bz display7
    decf 0x20
    bz display8
    goto display9
display0:
    bsf PORTB, 0
    movlw b'11101101'
    goto display_end
display1:
    bsf PORTB, 0
    movlw b'1000000'
    goto display_end
display2:
    bcf PORTB, 0
    movlw b'11001110'
    goto display_end
display3:
    bsf PORTB, 0
    movlw b'11001010'
    goto display_end
display4:
    bsf PORTB, 0
    movlw b'1000011'
    goto display_end
display5:
    bsf PORTB, 0
    movlw b'10001011'
    goto display_end
display6:
    bsf PORTB, 0
    movlw b'10001111'
    goto display_end
display7:
    bsf PORTB, 0
    movlw b'11000000'
    goto display_end
display8:
    bsf PORTB, 0
    movlw b'11101111'
    goto display_end
display9:
    bsf PORTB, 0
    movlw b'11101011'
    goto display_end
display_end:
    movwf PORTA
    return
    
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