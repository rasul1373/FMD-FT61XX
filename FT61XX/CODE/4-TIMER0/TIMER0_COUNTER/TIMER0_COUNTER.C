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
//Function name：interrupt ISR
//parameters：无
//returned value：无
//===========================================================
void interrupt ISR(void)
{
    if(T0IE && T0IF)
    {
        RC5=1;
        delayMs(100);
        RC5=0;
                RC5=1;
        delayMs(100);
        RC5=0;
                RC5=1;
        delayMs(100);
        RC5=0;
        
        T0IF=0;
        TMR0=65;
        //PC5 = ~PC5;
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
    PORTC = 0;
    
    TRISA = 1<<2;
    PORTA = 0;
    
    ANSEL = 0;
    
    
    PS0=1;
    PS1=0;
    PS2=0;
    T0CS=1;
    T0SE=0;
    PSA=0;
    
    GIE=1;
    T0IE=1;
    T0IF=0;
    
    TMR0=250;

    
    while(1)
    {
        if( a != TMR0)
        {
            a = TMR0;
            RC5=1;
            delayMs(100);
            RC5=0;
            
        } 


    }
}
//===========================================================
