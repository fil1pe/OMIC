PROCESSOR 16F628A
#include <p16f628a.inc>

__CONFIG _CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT

cblock 0x23
salva_w
iDivRepeat
f_divlo
f_divhi
cont1
contador
endc

ORG 0x000
goto setup

org 0x04
goto interrupcao
    
setup:
    movlw 0x07
    movwf CMCON
    banksel TRISA
    clrf TRISA
    clrf TRISB
    bsf TRISB, 4
    bsf TRISB, 5
    bcf INTCON, RBIF
    bsf INTCON, GIE
    bsf INTCON, RBIE
    
    banksel PORTA
    movlw 5
    movwf contador
    call display
main:
    goto main

interrupcao:
    btfss INTCON, RBIF
    goto reativa_int
    
    btfss PORTB, 4 ; verifica se foi RB4 que subiu para 1
    goto liberaBotao1
    
    banksel PORTA
    decf contador
    movfw contador
    
    incf contador
    skpnz 
    movlw 9
    movwf contador
    
    call display
liberaBotao1:
    call delay_debounce
    btfsc PORTB, 4
    goto liberaBotao1
    
    btfss PORTB, 5 ; verifica se foi RB5 que subiu para 1
    goto liberaBotao2
    
    banksel PORTA
    incf contador
    movlw 0
    movwf f_divhi
    
    movfw contador
    movwf f_divlo
    
    movlw b'1010'
    call DivisaoInteira
    movfw f_divhi
    movwf contador
    
    call display
liberaBotao2:
    call delay_debounce
    btfsc PORTB, 5
    goto liberaBotao2
reativa_int:
    call delay_omic
    bcf INTCON, RBIF
    retfie

delay_omic:
    movlw 0xFF
    movwf f_divhi
delay_loop:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    decf f_divlo
    bnz delay_loop
    return

delay_debounce:
    movlw D'12'
    movwf cont1
loop_debounce:
    decfsz cont1, f
    goto loop_debounce
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