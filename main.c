
#define F_CPU 16000000
#define BAUD 9600

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <avr/io.h>
#include <avr/sleep.h>
#include <avr/interrupt.h>
#include <avr/power.h>
#include <util/delay.h> 
#include <util/setbaud.h>
#include <compat/twi.h>

int main(void)
{
    DDRB |= (1 << PB5);
	while(1){
        PORTB |= (1 << PB5);
        _delay_ms(500);
        PORTB &= ~(1 << PB5);
        _delay_ms(500);
	}
    
	return 0;
}
