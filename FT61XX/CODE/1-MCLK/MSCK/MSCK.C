//Project: MSCK.prj
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

//===========================================================
//Function name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void)
{
}

void delayUs(unsigned char time)
{
    unsigned char a;
    for(a=0;a<time;a++)
    {
        NOP();
    }
}
//===========================================================
//Function name：main
//parameters：无
//returned value：无
//===========================================================
main()
{
    OSCCON = 0B01100001;    //16Mhz/4=4Mhz
    
 TRISC = 0;
 PORTC = 0;
 
while(1)
{
PORTC |= 1<<5;
delayUs(100);
PORTC &= ~(1<<5); 
delayUs(100);
}
}
//===========================================================
