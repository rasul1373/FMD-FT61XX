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

//===========================================================
//Function name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void)
{
    if(TMR1IF)
    {
       TMR1IF=0;
       TMR1L=0x66;
       TMR1H=0xc1; 
       RC5 = ~RC5;
    }
}
//===========================================================
//Function name：main
//parameters：无
//returned value：无
//===========================================================
main()
{
    OSCCON = 0B01110001;
    
    TRISC = 0;
    WPUC = 0;
    PORTC = 0;
     
    TMR1L=0x66;
    TMR1H=0xc1;
    TMR1ON=1;
    TMR1IE=1;
    PEIE=1;
    GIE=1;
    TMR1IF=0;
    
    
    
    while(1)
    {
 
    }
}
//===========================================================
