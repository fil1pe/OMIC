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
    PORTA = 0b00000010;
}
