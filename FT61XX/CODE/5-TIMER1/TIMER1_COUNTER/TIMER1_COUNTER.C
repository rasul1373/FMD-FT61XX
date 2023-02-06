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
volatile unsigned char a=0;
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
    
    TMR1CS=1;
    T1CKPS0=1;
    T1CKPS1=0;
    
    
    while(1)
    {
        if( TMR1L != a)
        {
            a = TMR1L;
            RC5 = ~RC5;
            delayMs(200);
            RC5 = ~RC5;
            
        }
 

    }
}
//===========================================================
