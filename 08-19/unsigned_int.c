#define _XTAL_FREQ 4000000

#include <pic16f628a.h>
#include <xc.h>

#pragma config LVP = OFF
#pragma config CP = OFF
#pragma config BOREN = ON
#pragma config MCLRE = OFF
#pragma config WDTE = OFF
#pragma config PWRTE = ON
#pragma config FOSC = INTOSCCLK

void main(){
    CMCON = 0x07;
    TRISA = 0b00000000;
    unsigned int contador = 0;
    while(contador++ < 5){
        RA2 = 0;
        __delay_ms(1000);
        RA2 = 1;
        __delay_ms(1000);
    }
    while(1){
        RA2 = 0;
        __delay_ms(500);
        RA2 = 1;
        __delay_ms(500);
    }
}
