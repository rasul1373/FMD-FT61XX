#include	"SYSCFG.h";
#include	"FT61F02X.h";


#define		uchar	unsigned char 

#define		TXIO	PA4	
#define		RXIO	PC1	

#define		Bord	49 
uchar RXFLAG = 0;
uchar ReadAPin;

void POWER_INITIAL(void)
{
	OSCCON = 0B01110001;	
    
	PORTA = 0B00000000;		
	TRISA = 0B00000000;		
    
    TRISC = 1<<1;
    WPUC = 1<<1;
    PORTC = 0;
    
    ANSEL5 = 0;
    CMCON0 = 0B00000111;
    INTEDG = 0;
    INTE=1;
    GIE=1;
    INTF=0;

}

void TIMER0_INITIAL (void)  
{
	OPTION = 0B00000000;    
	TMR0 = Bord; 
    T0IF = 0;								
}


void interrupt ISR(void)			       
{ 
	
	if(T0IE && T0IF)						
	{
		TMR0 = Bord;						
		T0IF = 0;
        T0IE = 0;
	} 
    

	if(INTE && INTF)		
    {	
		INTF = 0;  							
		if(RXIO == 0)
        {
        	INTE = 0;  								
            RXFLAG = 1;
        } 
    }
} 

void WaitTF0( void )
{
     while(T0IE);
     T0IE=1;
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

void WByte(uchar input)
{
	                                        //发送起始位
	uchar i=8;
	TXIO = 1;
	TMR0 = Bord;
	T0IE = 1;  
	WaitTF0(); 
	TXIO=0;
	WaitTF0();
	                                        //发送8位数据位
	while(i--)
	{
		if(input&0x01) 						//先传低位
		{
			TXIO=1;
		}
		else
		{
			TXIO = 0;
		}    
		WaitTF0();
		input=input>>1;
	}
	                                        //发送校验位(无)
	                                        //发送结束位
	TXIO=(bit)1;
	T0IE=0;
} 

uchar RByte()
{
	uchar Output=0;
	uchar i=8;
	T0IE=1;                          		//启动Timer0
	TMR0 = Bord;
	WaitTF0();
	T0IE=1;                          		//启动Timer0
	TMR0 = Bord;
	WaitTF0();                     			//等过起始位
	                                        //发送8位数据位
	while(i--)
	{
		Output >>=1;
		if(RXIO) 
        {
        	Output   |=0x80;      			//先收低位
        }
		WaitTF0();                 			//位间延时
	}
	T0IE=0;                          		//停止Timer0
	return Output;
}

void main(void)
{
	uchar rdata = 0;
	POWER_INITIAL();
    TIMER0_INITIAL();
    GIE = 1; 								
	T0IE = 1;								
    while(1)
    {
       /* 
        if(RXFLAG)							
        {
        	rdata = RByte();
            WByte(rdata);
			INTE =1;   						
            RXFLAG = 0;
        }
        */
        delayMs(50);
        WByte(0x55);
      
    }
}