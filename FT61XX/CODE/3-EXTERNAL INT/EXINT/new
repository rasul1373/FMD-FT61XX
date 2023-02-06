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

void delayUs(unsigned char time)
{
    unsigned char a;
    for(a=0;a<time;a++)
    {
        NOP();
    }
}   

void delayMs(unsigned char time)
{
    unsigned char a,b;
    
    for(b=0;b<5;b++)
    {
      for(a=0;a<time;a++)
    {
        delayUs(197);
    }  
    }

}   

//===========================================================
//Function name??interrupt ISR
//parameters????
//returned value????
//===========================================================
void interrupt ISR(void)
{
    if(INTF == 1)
    {
        INTF=0;

     PORTC |= 1<<4;
     delayMs(100);
     PORTC &= ~(1<<4); 
     delayMs(100); 
     
     PORTC |= 1<<4;
     delayMs(100);
     PORTC &= ~(1<<4); 
     delayMs(100); 
    }
}
//===========================================================
//Function name??main
//parameters????
//returned value????
//===========================================================
main()
{
    OSCCON = 0B01110001;
    
    TRISC = 1<<1;
    WPUC = 1<<1;
    PORTC = 0;
    
    ANSEL5 = 0;
    CMCON0 = 0B00000111;
    INTEDG = 0;
    INTE=1;
    GIE=1;
    INTF=0;
    
    while(1)
    {

     PORTC |= 1<<5;
     delayMs(500);
     PORTC &= ~(1<<5); 
     delayMs(500); 

    }
}
//===========================================================
