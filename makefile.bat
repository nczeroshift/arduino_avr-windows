@ECHO OFF
setlocal
REM Set the env variable AVR_TOOLCHAIN to where arduino avr toolchain is stored
SET errHandler=^|^| ^(EXIT /B %errorlevel%^)
SET CC=%AVR_TOOLCHAIN%\bin\avr-gcc.exe
SET OBJ_COPY=%AVR_TOOLCHAIN%\bin\avr-objcopy.exe
SET OBJ_BUILD=%CC% -I %AVR_TOOLCHAIN%\include -mmcu=atmega328p -g -std=c99 -Wall -Wstrict-prototypes -mcall-prologues -Os

IF "%1" == "" ( 
    IF NOT EXIST out (mkdir out)
    ECHO building main.c ... & %OBJ_BUILD% -c main.c -o out/main.o %errHandler%
    ECHO building program ... & %CC% -o out/program.out -Wl,-Map,out/program.map out/main.o %errHandler%
    ECHO writing hex ... & %OBJ_COPY%  -R .eeprom -O ihex out/program.out out/program.hex %errHandler%
    @EXIT /B 0
)

IF "%1" == "load" (
    avrdude -C "%AVR_TOOLCHAIN%\etc\avrdude.conf" -c arduino -b 57600 -P COM5 -p atmega328p -u -U flash:w:out/program.hex
    @EXIT /B 0
)

IF  "%1" == "fuses" (
    @EXIT /B 0
)

IF  "%1" == "clear" (
    IF EXIST out (rmdir /s /q out)
@EXIT /B 0
)