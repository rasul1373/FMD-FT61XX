
//*********************************************************
#include "SYSCFG.h"
//***********************∫Í∂®“Â****************************
#define  unchar     unsigned char 
#define  unint      unsigned int

#define  MISO		PA4   
#define  MOSI 		PA2
#define  SCK		PA6
#define  CS			PA7

unchar 	SPIReadData;


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
	
		  
unchar SPI_RW(unchar data)
{
   unchar i; 
   for(i=0;i<8;i++)
   {
    if(data&0x80)
      MOSI = 1;
    else
      MOSI = 0;
    NOP();
    data<<=1;
    SCK  =  1;
	NOP();
    if(MISO)
      data  |= 0x01;
    else
      data  &= 0xFE;
	NOP();
    SCK  =  0;
   }
   return data;
 }

void main()
{
    OSCCON = 0B01110001;			
	PORTA = 0B00000000;				
	TRISA = 0B00010000;				
    WPUA = 0B00010000;   
    
    CS = 1;
 	SCK = 0;
    MOSI = 0;
    
	while(1)
	{
        
for(unsigned char i=0 ; i<255 ; i++)
{
   CS=0; 
   SPI_RW(0x11);
   SPI_RW(i); 
   CS=1; 
   delayMs(30);
}
	}
}
