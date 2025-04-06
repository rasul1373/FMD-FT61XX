//Project: gpio.prj
// Device: FT61F02X
// Memory: Flash 2KX14b, EEPROM 256X8b, SRAM 128X8b
// Author: 
//Company: 
//Version:
//   Date: 
//===========================================================
//===========================================================
#include	"SYSCFG.h"
//===========================================================
//Variable definition
//===========================================================
volatile unsigned char test=0;
unsigned char EEPROMread(unsigned char EEAddr)
{
		unsigned char read;
        
		EEADR = EEAddr;
        RD = 1;
        read = EEDAT;
		return read;

}


void EEPROMwrite(unsigned char EEAddr , unsigned char data)
{
		GIE = 0;
        while(GIE);
        EEADR = EEAddr;
        EEDAT = data;
        EEIF = 0;
        WREN1 = 1;
        WREN2 = 1;
        WREN3 = 1;
        WR = 1;
        while (WR);
        GIE = 1;
        
        
        
}







//===========================================================
//Function name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void)
{
}
//===========================================================
//Function name：main
//parameters：无
//returned value：无
//===========================================================
main()
{
    OSCCON = 0B01110001;

    EEPROMwrite(0x12,0x55);
    test = EEPROMread(0x12);
    while(1)
    {
	NOP();
    }
}
//===========================================================