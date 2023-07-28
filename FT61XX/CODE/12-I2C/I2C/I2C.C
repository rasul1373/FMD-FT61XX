
#include "SYSCFG.h"

#define	unchar	unsigned char 

#define	IIC_SCL	PA4   
#define	IIC_SDA	PA2

#define	SDA_OUT	TRISA2 = 0
#define	SDA_IN	TRISA2 = 1

volatile unchar sec;
	
void POWER_INITIAL (void) 
{
	OSCCON = 0B01110001;	
	INTCON = 0;				
	PORTA = 0B00000000;				
	TRISA = 0B00000000;		
	ANSEL = 0B00000000;

}

void DelayUs(unsigned char Time)
{
	unsigned char a;
	for(a=0;a<Time;a++)
	{
		NOP();
	}
}                  

void IIC_Start(void)
{
	SDA_OUT;              
	IIC_SDA=1;	  	  
	IIC_SCL=1;
	DelayUs(10);
 	IIC_SDA=0;            
	DelayUs(10);
	IIC_SCL=0;            
    DelayUs(10);
}	  

 void IIC_Stop(void)
{
	SDA_OUT;              
	IIC_SCL=0;
	IIC_SDA=0;            
 	DelayUs(10);
	IIC_SCL=1;
    DelayUs(10); 
	IIC_SDA=1;            
	DelayUs(10);							   	
}

unsigned char IIC_Wait_Ack(void)
{
	unsigned char ucErrTime=0;      
	SDA_IN;               
	IIC_SDA=1;
	DelayUs(5);	   
	IIC_SCL=1;
	DelayUs(5);	 
	while(IIC_SDA)
	{
		ucErrTime++;
		if(ucErrTime>250) 
		{
			IIC_Stop();
			return 1;
		}
	}
	IIC_SCL=0;            
	return 0;  
} 

void IIC_Ack(void)
{
	IIC_SCL=0;
	SDA_OUT;              
	IIC_SDA=0;
	DelayUs(5);	
	IIC_SCL=1;
	DelayUs(5);	
	IIC_SCL=0;
}
    
void IIC_NAck(void)
{
	IIC_SCL=0;
	SDA_OUT;             
	IIC_SDA=1;
	DelayUs(5);	
	IIC_SCL=1;
	DelayUs(5);	
	IIC_SCL=0;
}					 				     
	  
void IIC_Send_Byte(unsigned char txd)
{                        
    unsigned char t;   
	SDA_OUT;	          
    IIC_SCL=0;            
    for(t=0;t<8;t++)
    {              
		if((txd&0x80)>>7)
			IIC_SDA=1;
		else
			IIC_SDA=0;
		txd<<=1; 	  
		DelayUs(5);				  
		IIC_SCL=1;
		DelayUs(5);	
		IIC_SCL=0;	
		DelayUs(5);
    }	 
} 	    

 unsigned char IIC_Read_Byte(void)
{
	unsigned char i,receive=0;
	SDA_IN;              
    for(i=0;i<8;i++ )
	{
        IIC_SCL=0; 
        DelayUs(5);	
     	IIC_SCL=1;
        receive<<=1;
        if(IIC_SDA)receive++;   
		DelayUs(5);	
    }					 
    IIC_NAck();           
  
    return receive;
}

 unsigned char IIC_READ(unsigned char address)
	{
	unsigned char iicdata = 0;
	IIC_READ_Begin:
		IIC_Start();
		IIC_Send_Byte(0xd0);
		if(IIC_Wait_Ack())goto IIC_READ_Begin;
		IIC_Send_Byte(address);				
		if(IIC_Wait_Ack())goto IIC_READ_Begin; 
		IIC_Start();
		IIC_Send_Byte(0xd1);
		if(IIC_Wait_Ack())goto IIC_READ_Begin;
		iicdata=IIC_Read_Byte();
		IIC_Stop();		
		return iicdata;
	}

void IIC_WRITE(unsigned char address,unsigned char data)
	{
	IIC_WRITE_Begin:
		IIC_Start();
		IIC_Send_Byte(0xd0);
		if(IIC_Wait_Ack())goto IIC_WRITE_Begin;

		IIC_Send_Byte(address);
		if(IIC_Wait_Ack())goto IIC_WRITE_Begin;

		IIC_Send_Byte(data);
		if(IIC_Wait_Ack())goto IIC_WRITE_Begin;

		IIC_Stop();	
	}

 unsigned char bcd2bin(unsigned char x)
{
  unsigned char bin;
	bin=((x & 0xf0)>>4)*10 +(x & 0x0f);
  return (bin);
}

unsigned char hex2bcd (unsigned char x)
{
	unsigned char y;
	y = (x/10) <<4;
	y = y | (x % 10);
	return (y);	
}
void main()
{
	POWER_INITIAL();				    

    IIC_WRITE(0x00,0x7f);
    IIC_WRITE(0x00,0x03);
	while(1)
	{
        

    sec=IIC_READ(0x00);
    sec=bcd2bin(sec);
    	NOP();
	}
}