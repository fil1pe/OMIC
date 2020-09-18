PROCESSOR 16F628A
#include <p16f628a.inc>

__CONFIG _CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

cblock 0x23
salva_w
iDivRepeat
f_divlo
f_divhi
contador
countH
countM
countL
endc

ORG 0x000
goto setup
    
setup:
    movlw 0x07
    movwf CMCON
    banksel TRISA
    clrf TRISA
    clrf TRISB
    clrwdt
    movlw b'11010000'
    option
    
    banksel PORTA
    movlw 0
    movwf contador
    call display
main:
    movlw b'10000000'
    movwf countL
    movlw b'10000100'
    movwf countM
    movlw b'11110'
    movwf countH
    call TM0delay
    
    call inc_contador
    call display
    
    movlw b'00100000'
    movwf countL
    movlw b'10100001'
    movwf countM
    movlw b'111'
    movwf countH
    call TM0delay
    
    call inc_contador
    call display
    
    goto main

inc_contador:
    movlw 0
    movwf f_divhi
    incf contador
    movfw contador
    movwf f_divlo
    movlw b'1010'
    call DivisaoInteira
    movfw f_divhi
    movwf contador
    return

TM0delay:
    bcf STATUS, C
    rrf countL, f
    movfw countL
    sublw d'128'
    movwf TMR0
cycle:
    btfss TMR0, 7
    goto cycle
    bcf TMR0, 7
    decfsz countM, f
    goto cycle
    decfsz countH, f
    goto cycle
    return

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

    ;Divis?o inteira de 16 bits por 8 bits com resto
    ;piclist.com/techref/microchip/math/div/16by8lz.htm
    ; Chamada: Os 16 bits do dividendo em f_divhi:f_divlo, divisor em W.
    ; Retorno: Quociente em f_divlo, resto em f_divhi. W preservado.
    ;          STATUS: C setado em caso de erro. Z setado caso divis?o por zero. NZ em caso de overflow.
    
DivisaoInteira:
    addlw 0          ; w+=0 (to test for div by zero)
    bsf STATUS, C    ; seta carry
    btfsc STATUS, Z    ; verifica se o flag zero est? habilitado
    return           ; retorna ao chamador
    call DivSkipHiShift
    movwf salva_w
    movlw 0x8
    movwf iDivRepeat
loopDivCode:
    movfw salva_w;carregue o valor salvo de w
    call DivCode ;rotacionar e subtrair
    decf iDivRepeat, 1;decrementarContador
    movfw iDivRepeat;carregar contador para w
    andlw 0xFF ;and com 1111 1111. Vai setar Z se der 0
    btfss STATUS, Z;verifica se chegou em zero
    goto loopDivCode;se n?o chegou em 0, volta para loop
    
    movfw salva_w;carregue o valor salvo de w depois de sair do loop
    rlf f_divlo, 1 ; C << lo << C

    ; If the first subtract didn't underflow, and the carry was shifted
    ; into the quotient, then it will be shifted back off the end by this
    ; last RLF. This will automatically raise carry to indicate an error.
    ; The divide will be accurate to quotients of 9-bits, but past that
    ; the quotient and remainder will be bogus and carry will be set.

    bcf STATUS, Z  ; NZ (in case of overflow error)
    return       ; we are done!

DivCode
    rlf f_divlo, 1    ; C << lo << C
    rlf f_divhi, 1    ; C << hi << C
    btfss STATUS, C       ; if Carry
    goto DivSkipHiShift ;
    subwf f_divhi, 1  ;   hi-=w
    bsf STATUS,C         ;   ignore carry
    return               ;   done
                         ; endif
DivSkipHiShift
    subwf f_divhi, 1 ; hi-=w
    btfsc STATUS, C ; if carry set
    return ;   done
    addwf f_divhi, 1 ; hi+=w
    bcf STATUS, C ; clear carry
    return ; done
    
    end
