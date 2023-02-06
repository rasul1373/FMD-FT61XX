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

unsigned int get_adc(unsigned char ch)
{
    unsigned char ADCON0buff;
    unsigned int adc_data=0;
    
    ADCON0buff = ADCON0 & 0B11100011;
    ch <<=2;
    ADCON0buff |= ch;
    ADCON0 = ADCON0buff;
    delayUs(20);
    GO_DONE=1;
    while(GO_DONE ==1);
    
    adc_data = ADRESH;
    adc_data <<=8 ;
    adc_data |= ADRESL;
    
    return adc_data;
    
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
    TRISC4=1;
    PWM3CR0 = 0B00110010;
    PWM3CR1 = 0B10000000;
    TMR3L=0;
    TMR3H=0;
    T3CKDIV=25;
    PR3L=0;
    PR3H0=0;
    PR3H1=0;
    PR3H2=0;
    PR3H3=0;
    TRISC4=0;
    TMR3ON=1;

    ANSEL=0B00000100;
    ADCON1=0B01100000;
    ADCON0=0B10001001;
    

    while(1)
    {
        PR3L = get_adc(2)>>2;
        NOP();
    }

}
//===========================================================
