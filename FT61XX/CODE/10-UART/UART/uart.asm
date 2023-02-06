//Deviec:FT61F02X
//-----------------------Variable---------------------------------
		_RXFLAG		EQU		75H
//		main@rdata		EQU		74H
//		WByte@input		EQU		72H
//		WByte@i		EQU		73H
//		WByte@input		EQU		72H
//		WByte@input		EQU		72H
//		RByte@Output		EQU		73H
//		RByte@i		EQU		72H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	70H 			//0006 	01F0
		LDR 	PCLATH,0 		//0007 	080A
		STR 	71H 			//0008 	01F1
		LJUMP 	0EH 			//0009 	380E
		LJUMP 	0BH 			//000A 	380B
		CLRR 	75H 			//000B 	0175
		CLRR 	STATUS 			//000C 	0103
		LJUMP 	6FH 			//000D 	386F

		//;UART.C: 45: if(T0IE && T0IF)
		BTSC 	INTCON,5 		//000E 	168B
		BTSS 	INTCON,2 		//000F 	1D0B
		LJUMP 	17H 			//0010 	3817

		//;UART.C: 46: {
		//;UART.C: 47: TMR0 = 49;
		LDWI 	31H 			//0011 	2A31
		BCR 	STATUS,5 		//0012 	1283
		BCR 	STATUS,6 		//0013 	1303
		STR 	1H 			//0014 	0181

		//;UART.C: 48: T0IF = 0;
		BCR 	INTCON,2 		//0015 	110B

		//;UART.C: 49: T0IE = 0;
		BCR 	INTCON,5 		//0016 	128B

		//;UART.C: 50: }
		//;UART.C: 53: if(INTE && INTF)
		BTSC 	INTCON,4 		//0017 	160B
		BTSS 	INTCON,1 		//0018 	1C8B
		LJUMP 	22H 			//0019 	3822

		//;UART.C: 54: {
		//;UART.C: 55: INTF = 0;
		BCR 	INTCON,1 		//001A 	108B

		//;UART.C: 56: if(PC1 == 0)
		BCR 	STATUS,5 		//001B 	1283
		BCR 	STATUS,6 		//001C 	1303
		BTSC 	7H,1 			//001D 	1487
		LJUMP 	22H 			//001E 	3822

		//;UART.C: 57: {
		//;UART.C: 58: INTE = 0;
		BCR 	INTCON,4 		//001F 	120B

		//;UART.C: 59: RXFLAG = 1;
		CLRR 	75H 			//0020 	0175
		INCR	75H,1 			//0021 	09F5
		LDR 	71H,0 			//0022 	0871
		STR 	PCLATH 			//0023 	018A
		SWAPR 	70H,0 			//0024 	0770
		STR 	STATUS 			//0025 	0183
		SWAPR 	7EH,1 			//0026 	07FE
		SWAPR 	7EH,0 			//0027 	077E
		RETI		 			//0028 	0009
		STR 	72H 			//0029 	01F2

		//;UART.C: 96: unsigned char i=8;
		LDWI 	8H 			//002A 	2A08
		STR 	73H 			//002B 	01F3

		//;UART.C: 97: PA4 = 1;
		BSR 	5H,4 			//002C 	1A05

		//;UART.C: 98: TMR0 = 49;
		LDWI 	31H 			//002D 	2A31
		STR 	1H 			//002E 	0181

		//;UART.C: 99: T0IE = 1;
		BSR 	INTCON,5 		//002F 	1A8B

		//;UART.C: 100: WaitTF0();
		LCALL 	83H 			//0030 	3083

		//;UART.C: 101: PA4=0;
		BCR 	5H,4 			//0031 	1205

		//;UART.C: 102: WaitTF0();
		LCALL 	83H 			//0032 	3083

		//;UART.C: 104: while(i--)
		LJUMP 	3CH 			//0033 	383C

		//;UART.C: 105: {
		//;UART.C: 106: if(input&0x01)
		BTSS 	72H,0 			//0034 	1C72
		LJUMP 	38H 			//0035 	3838

		//;UART.C: 107: {
		//;UART.C: 108: PA4=1;
		BSR 	5H,4 			//0036 	1A05

		//;UART.C: 109: }
		LJUMP 	39H 			//0037 	3839

		//;UART.C: 110: else
		//;UART.C: 111: {
		//;UART.C: 112: PA4 = 0;
		BCR 	5H,4 			//0038 	1205

		//;UART.C: 113: }
		//;UART.C: 114: WaitTF0();
		LCALL 	83H 			//0039 	3083

		//;UART.C: 115: input=input>>1;
		BCR 	STATUS,0 		//003A 	1003
		RRR	72H,1 			//003B 	06F2
		DECR 	73H,1 			//003C 	0DF3
		INCRSZ 	73H,0 		//003D 	0A73
		LJUMP 	34H 			//003E 	3834

		//;UART.C: 116: }
		//;UART.C: 119: PA4=(bit)1;
		BSR 	5H,4 			//003F 	1A05

		//;UART.C: 120: T0IE=0;
		BCR 	INTCON,5 		//0040 	128B
		RET		 					//0041 	0004

		//;UART.C: 16: OSCCON = 0B01110001;
		LDWI 	71H 			//0042 	2A71
		BSR 	STATUS,5 		//0043 	1A83
		STR 	FH 			//0044 	018F

		//;UART.C: 18: PORTA = 0B00000000;
		BCR 	STATUS,5 		//0045 	1283
		CLRR 	5H 			//0046 	0105

		//;UART.C: 19: TRISA = 0B00000000;
		BSR 	STATUS,5 		//0047 	1A83
		CLRR 	5H 			//0048 	0105

		//;UART.C: 21: TRISC = 1<<1;
		LDWI 	2H 			//0049 	2A02
		STR 	7H 			//004A 	0187

		//;UART.C: 22: WPUC = 1<<1;
		STR 	8H 			//004B 	0188

		//;UART.C: 23: PORTC = 0;
		BCR 	STATUS,5 		//004C 	1283
		CLRR 	7H 			//004D 	0107

		//;UART.C: 25: ANSEL5 = 0;
		BSR 	STATUS,5 		//004E 	1A83
		BCR 	11H,5 			//004F 	1291

		//;UART.C: 26: CMCON0 = 0B00000111;
		LDWI 	7H 			//0050 	2A07
		BCR 	STATUS,5 		//0051 	1283
		STR 	19H 			//0052 	0199

		//;UART.C: 27: INTEDG = 0;
		BSR 	STATUS,5 		//0053 	1A83
		BCR 	1H,6 			//0054 	1301

		//;UART.C: 28: INTE=1;
		BSR 	INTCON,4 		//0055 	1A0B

		//;UART.C: 29: GIE=1;
		BSR 	INTCON,7 		//0056 	1B8B

		//;UART.C: 30: INTF=0;
		BCR 	INTCON,1 		//0057 	108B
		RET		 					//0058 	0004
		LDWI 	8H 			//0059 	2A08

		//;UART.C: 125: unsigned char Output=0;
		CLRR 	73H 			//005A 	0173

		//;UART.C: 126: unsigned char i=8;
		STR 	72H 			//005B 	01F2

		//;UART.C: 127: T0IE=1;
		BSR 	INTCON,5 		//005C 	1A8B

		//;UART.C: 128: TMR0 = 49;
		LDWI 	31H 			//005D 	2A31
		STR 	1H 			//005E 	0181

		//;UART.C: 129: WaitTF0();
		LCALL 	83H 			//005F 	3083

		//;UART.C: 130: T0IE=1;
		BSR 	INTCON,5 		//0060 	1A8B

		//;UART.C: 131: TMR0 = 49;
		LDWI 	31H 			//0061 	2A31
		STR 	1H 			//0062 	0181

		//;UART.C: 134: while(i--)
		LJUMP 	68H 			//0063 	3868

		//;UART.C: 135: {
		//;UART.C: 136: Output >>=1;
		BCR 	STATUS,0 		//0064 	1003
		RRR	73H,1 			//0065 	06F3

		//;UART.C: 137: if(PC1)
		BTSC 	7H,1 			//0066 	1487

		//;UART.C: 138: {
		//;UART.C: 139: Output |=0x80;
		BSR 	73H,7 			//0067 	1BF3

		//;UART.C: 132: WaitTF0();
		LCALL 	83H 			//0068 	3083
		DECR 	72H,1 			//0069 	0DF2
		INCRSZ 	72H,0 		//006A 	0A72
		LJUMP 	64H 			//006B 	3864

		//;UART.C: 142: }
		//;UART.C: 143: T0IE=0;
		BCR 	INTCON,5 		//006C 	128B

		//;UART.C: 144: return Output;
		LDR 	73H,0 			//006D 	0873
		RET		 					//006E 	0004

		//;UART.C: 150: POWER_INITIAL();
		LCALL 	42H 			//006F 	3042

		//;UART.C: 151: TIMER0_INITIAL();
		LCALL 	7DH 			//0070 	307D

		//;UART.C: 152: GIE = 1;
		BSR 	INTCON,7 		//0071 	1B8B

		//;UART.C: 153: T0IE = 1;
		BSR 	INTCON,5 		//0072 	1A8B

		//;UART.C: 155: {
		//;UART.C: 157: if(RXFLAG)
		LDR 	75H,0 			//0073 	0875
		BTSC 	STATUS,2 		//0074 	1503
		LJUMP 	73H 			//0075 	3873

		//;UART.C: 158: {
		//;UART.C: 159: rdata = RByte();
		LCALL 	59H 			//0076 	3059
		STR 	74H 			//0077 	01F4

		//;UART.C: 160: WByte(rdata);
		LDR 	74H,0 			//0078 	0874
		LCALL 	29H 			//0079 	3029

		//;UART.C: 161: INTE =1;
		BSR 	INTCON,4 		//007A 	1A0B

		//;UART.C: 162: RXFLAG = 0;
		CLRR 	75H 			//007B 	0175
		LJUMP 	73H 			//007C 	3873

		//;UART.C: 36: OPTION = 0B00000000;
		CLRR 	1H 			//007D 	0101

		//;UART.C: 37: TMR0 = 49;
		LDWI 	31H 			//007E 	2A31
		BCR 	STATUS,5 		//007F 	1283
		STR 	1H 			//0080 	0181

		//;UART.C: 38: T0IF = 0;
		BCR 	INTCON,2 		//0081 	110B
		RET		 					//0082 	0004

		//;UART.C: 66: while(T0IE);
		BTSC 	INTCON,5 		//0083 	168B
		ORG		0084H
		LJUMP 	83H 			//0084 	3883

		//;UART.C: 67: T0IE=1;
		BSR 	INTCON,5 		//0085 	1A8B
		RET		 					//0086 	0004
			END
