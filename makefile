MCU=atmega328p
CC=avr-gcc
OBJCOPY=avr-objcopy
CFLAGS=-g -std=c99 -mmcu=$(MCU) -Wall -Wstrict-prototypes -Os -mcall-prologues

all: program.hex

program.hex : program.out 
	$(OBJCOPY) -R .eeprom -O ihex program.out program.hex
program.out : main.o
	$(CC) $(CFLAGS) -o program.out -Wl,-Map,program.map main.o
main.o : main.c 
	$(CC) $(CFLAGS) -Os -c main.c

load: program.hex
	sudo avrdude -c arduino -b 57600 -P /dev/ttyUSB0 -p $(MCU) -u -U flash:w:program.hex

clean:
	rm -f *.o *.map *.out *.hex

