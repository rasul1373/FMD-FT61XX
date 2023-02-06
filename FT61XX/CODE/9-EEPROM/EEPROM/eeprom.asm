//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//		delayMs@time		EQU		74H
//		delayMs@b		EQU		76H
//		delayMs@a		EQU		75H
//		delayMs@time		EQU		74H
//		delayMs@time		EQU		74H
//		delayUs@time		EQU		72H
//		delayUs@a		EQU		73H
//		delayUs@time		EQU		72H
//		delayUs@time		EQU		72H
//		WByte@input		EQU		72H
//		WByte@i		EQU		73H
//		WByte@input		EQU		72H
//		WByte@input		EQU		72H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	70H 			//0006 	01F0
		LDR 	PCLATH,0 		//0007 	080A
		STR 	71H 			//0008 	01F1
		LJUMP 	28H 			//0009 	3828
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	68H 			//000C 	3868
		STR 	72H 			//000D 	01F2

		//;EEPROM.C: 96: unsigned char i=8;
		LDWI 	8H 			//000E 	2A08
		STR 	73H 			//000F 	01F3

		//;EEPROM.C: 97: PA4 = 1;
		BCR 	STATUS,5 		//0010 	1283
		BCR 	STATUS,6 		//0011 	1303
		BSR 	5H,4 			//0012 	1A05

		//;EEPROM.C: 98: TMR0 = 49;
		LDWI 	31H 			//0013 	2A31
		STR 	1H 			//0014 	0181

		//;EEPROM.C: 99: T0IE = 1;
		BSR 	INTCON,5 		//0015 	1A8B

		//;EEPROM.C: 100: WaitTF0();
		LCALL 	80H 			//0016 	3080

		//;EEPROM.C: 101: PA4=0;
		BCR 	5H,4 			//0017 	1205

		//;EEPROM.C: 102: WaitTF0();
		LCALL 	80H 			//0018 	3080

		//;EEPROM.C: 104: while(i--)
		LJUMP 	22H 			//0019 	3822

		//;EEPROM.C: 105: {
		//;EEPROM.C: 106: if(input&0x01)
		BTSS 	72H,0 			//001A 	1C72
		LJUMP 	1EH 			//001B 	381E

		//;EEPROM.C: 107: {
		//;EEPROM.C: 108: PA4=1;
		BSR 	5H,4 			//001C 	1A05

		//;EEPROM.C: 109: }
		LJUMP 	1FH 			//001D 	381F

		//;EEPROM.C: 110: else
		//;EEPROM.C: 111: {
		//;EEPROM.C: 112: PA4 = 0;
		BCR 	5H,4 			//001E 	1205

		//;EEPROM.C: 113: }
		//;EEPROM.C: 114: WaitTF0();
		LCALL 	80H 			//001F 	3080

		//;EEPROM.C: 115: input=input>>1;
		BCR 	STATUS,0 		//0020 	1003
		RRR	72H,1 			//0021 	06F2
		DECR 	73H,1 			//0022 	0DF3
		INCRSZ 	73H,0 		//0023 	0A73
		LJUMP 	1AH 			//0024 	381A

		//;EEPROM.C: 116: }
		//;EEPROM.C: 119: PA4=(bit)1;
		BSR 	5H,4 			//0025 	1A05

		//;EEPROM.C: 120: T0IE=0;
		BCR 	INTCON,5 		//0026 	128B
		RET		 					//0027 	0004

		//;EEPROM.C: 45: if(T0IE && T0IF)
		BTSC 	INTCON,5 		//0028 	168B
		BTSS 	INTCON,2 		//0029 	1D0B
		LJUMP 	31H 			//002A 	3831

		//;EEPROM.C: 46: {
		//;EEPROM.C: 47: TMR0 = 49;
		LDWI 	31H 			//002B 	2A31
		BCR 	STATUS,5 		//002C 	1283
		BCR 	STATUS,6 		//002D 	1303
		STR 	1H 			//002E 	0181

		//;EEPROM.C: 48: T0IF = 0;
		BCR 	INTCON,2 		//002F 	110B

		//;EEPROM.C: 49: T0IE = 0;
		BCR 	INTCON,5 		//0030 	128B

		//;EEPROM.C: 50: }
		//;EEPROM.C: 53: if(INTE && INTF)
		BTSC 	INTCON,4 		//0031 	160B
		BTSS 	INTCON,1 		//0032 	1C8B
		LJUMP 	39H 			//0033 	3839

		//;EEPROM.C: 54: {
		//;EEPROM.C: 55: INTF = 0;
		BCR 	INTCON,1 		//0034 	108B

		//;EEPROM.C: 56: if(PC1 == 0)
		BCR 	STATUS,5 		//0035 	1283
		BCR 	STATUS,6 		//0036 	1303
		BTSS 	7H,1 			//0037 	1C87

		//;EEPROM.C: 59: RXFLAG = 1;
		BCR 	INTCON,4 		//0038 	120B
		LDR 	71H,0 			//0039 	0871
		STR 	PCLATH 			//003A 	018A
		SWAPR 	70H,0 			//003B 	0770
		STR 	STATUS 			//003C 	0183
		SWAPR 	7EH,1 			//003D 	07FE
		SWAPR 	7EH,0 			//003E 	077E
		RETI		 			//003F 	0009

		//;EEPROM.C: 16: OSCCON = 0B01110001;
		LDWI 	71H 			//0040 	2A71
		BSR 	STATUS,5 		//0041 	1A83
		STR 	FH 			//0042 	018F

		//;EEPROM.C: 18: PORTA = 0B00000000;
		BCR 	STATUS,5 		//0043 	1283
		CLRR 	5H 			//0044 	0105

		//;EEPROM.C: 19: TRISA = 0B00000000;
		BSR 	STATUS,5 		//0045 	1A83
		CLRR 	5H 			//0046 	0105

		//;EEPROM.C: 21: TRISC = 1<<1;
		LDWI 	2H 			//0047 	2A02
		STR 	7H 			//0048 	0187

		//;EEPROM.C: 22: WPUC = 1<<1;
		STR 	8H 			//0049 	0188

		//;EEPROM.C: 23: PORTC = 0;
		BCR 	STATUS,5 		//004A 	1283
		CLRR 	7H 			//004B 	0107

		//;EEPROM.C: 25: ANSEL5 = 0;
		BSR 	STATUS,5 		//004C 	1A83
		BCR 	11H,5 			//004D 	1291

		//;EEPROM.C: 26: CMCON0 = 0B00000111;
		LDWI 	7H 			//004E 	2A07
		BCR 	STATUS,5 		//004F 	1283
		STR 	19H 			//0050 	0199

		//;EEPROM.C: 27: INTEDG = 0;
		BSR 	STATUS,5 		//0051 	1A83
		BCR 	1H,6 			//0052 	1301

		//;EEPROM.C: 28: INTE=1;
		BSR 	INTCON,4 		//0053 	1A0B

		//;EEPROM.C: 29: GIE=1;
		BSR 	INTCON,7 		//0054 	1B8B

		//;EEPROM.C: 30: INTF=0;
		BCR 	INTCON,1 		//0055 	108B
		RET		 					//0056 	0004
		STR 	74H 			//0057 	01F4

		//;EEPROM.C: 81: unsigned char a,b;
		//;EEPROM.C: 83: for(b=0;b<5;b++)
		CLRR 	76H 			//0058 	0176

		//;EEPROM.C: 84: {
		//;EEPROM.C: 85: for(a=0;a<time;a++)
		CLRR 	75H 			//0059 	0175
		LDR 	74H,0 			//005A 	0874
		SUBWR 	75H,0 			//005B 	0C75
		BTSC 	STATUS,0 		//005C 	1403
		LJUMP 	62H 			//005D 	3862

		//;EEPROM.C: 86: {
		//;EEPROM.C: 87: delayUs(197);
		LDWI 	C5H 			//005E 	2AC5
		LCALL 	71H 			//005F 	3071
		INCR	75H,1 			//0060 	09F5
		LJUMP 	5AH 			//0061 	385A
		LDWI 	5H 			//0062 	2A05
		INCR	76H,1 			//0063 	09F6
		SUBWR 	76H,0 			//0064 	0C76
		BTSC 	STATUS,0 		//0065 	1403
		RET		 					//0066 	0004
		LJUMP 	59H 			//0067 	3859

		//;EEPROM.C: 150: POWER_INITIAL();
		LCALL 	40H 			//0068 	3040

		//;EEPROM.C: 151: TIMER0_INITIAL();
		LCALL 	7AH 			//0069 	307A

		//;EEPROM.C: 152: GIE = 1;
		BSR 	INTCON,7 		//006A 	1B8B

		//;EEPROM.C: 153: T0IE = 1;
		BSR 	INTCON,5 		//006B 	1A8B

		//;EEPROM.C: 154: while(1)
		//;EEPROM.C: 155: {
		//;EEPROM.C: 165: delayMs(50);
		LDWI 	32H 			//006C 	2A32
		LCALL 	57H 			//006D 	3057

		//;EEPROM.C: 166: WByte(0x55);
		LDWI 	55H 			//006E 	2A55
		LCALL 	DH 			//006F 	300D
		LJUMP 	6CH 			//0070 	386C
		STR 	72H 			//0071 	01F2

		//;EEPROM.C: 72: unsigned char a;
		//;EEPROM.C: 73: for(a=0;a<time;a++)
		CLRR 	73H 			//0072 	0173
		LDR 	72H,0 			//0073 	0872
		SUBWR 	73H,0 			//0074 	0C73
		BTSC 	STATUS,0 		//0075 	1403
		RET		 					//0076 	0004

		//;EEPROM.C: 74: {
		//;EEPROM.C: 75: __nop();
		NOP		 					//0077 	0000
		INCR	73H,1 			//0078 	09F3
		LJUMP 	73H 			//0079 	3873

		//;EEPROM.C: 36: OPTION = 0B00000000;
		CLRR 	1H 			//007A 	0101

		//;EEPROM.C: 37: TMR0 = 49;
		LDWI 	31H 			//007B 	2A31
		BCR 	STATUS,5 		//007C 	1283
		STR 	1H 			//007D 	0181

		//;EEPROM.C: 38: T0IF = 0;
		BCR 	INTCON,2 		//007E 	110B
		RET		 					//007F 	0004

		//;EEPROM.C: 66: while(T0IE);
		BTSC 	INTCON,5 		//0080 	168B
		LJUMP 	80H 			//0081 	3880

		//;EEPROM.C: 67: T0IE=1;
		BSR 	INTCON,5 		//0082 	1A8B
		RET		 					//0083 	0004
			END
