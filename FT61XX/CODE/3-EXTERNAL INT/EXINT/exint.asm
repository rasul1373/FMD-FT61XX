//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//		delayMs@time		EQU		22H
//		delayMs@b		EQU		24H
//		delayMs@a		EQU		23H
//		delayMs@time		EQU		22H
//		delayMs@time		EQU		22H
//		delayUs@time		EQU		20H
//		delayUs@a		EQU		21H
//		delayUs@time		EQU		20H
//		delayUs@time		EQU		20H
//		i1delayMs@time		EQU		72H
//		i1delayMs@b		EQU		74H
//		i1delayMs@a		EQU		73H
//		i1delayMs@time		EQU		72H
//		i1delayMs@time		EQU		72H
//		i1delayUs@time		EQU		70H
//		i1delayUs@a		EQU		71H
//		i1delayUs@time		EQU		70H
//		i1delayUs@time		EQU		70H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	75H 			//0006 	01F5
		LDR 	PCLATH,0 		//0007 	080A
		STR 	76H 			//0008 	01F6
		LJUMP 	27H 			//0009 	3827
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0DH 			//000C 	380D

		//;EXINT.C: 67: OSCCON = 0B01110001;
		LDWI 	71H 			//000D 	2A71
		BSR 	STATUS,5 		//000E 	1A83
		STR 	FH 			//000F 	018F

		//;EXINT.C: 69: TRISC = 1<<1;
		LDWI 	2H 			//0010 	2A02
		STR 	7H 			//0011 	0187

		//;EXINT.C: 70: WPUC = 1<<1;
		STR 	8H 			//0012 	0188

		//;EXINT.C: 71: PORTC = 0;
		BCR 	STATUS,5 		//0013 	1283
		CLRR 	7H 			//0014 	0107

		//;EXINT.C: 73: ANSEL5 = 0;
		BSR 	STATUS,5 		//0015 	1A83
		BCR 	11H,5 			//0016 	1291

		//;EXINT.C: 74: CMCON0 = 0B00000111;
		LDWI 	7H 			//0017 	2A07
		BCR 	STATUS,5 		//0018 	1283
		STR 	19H 			//0019 	0199

		//;EXINT.C: 75: INTEDG = 0;
		BSR 	STATUS,5 		//001A 	1A83
		BCR 	1H,6 			//001B 	1301

		//;EXINT.C: 76: INTE=1;
		BSR 	INTCON,4 		//001C 	1A0B

		//;EXINT.C: 77: GIE=1;
		BSR 	INTCON,7 		//001D 	1B8B

		//;EXINT.C: 78: INTF=0;
		BCR 	INTCON,1 		//001E 	108B

		//;EXINT.C: 81: {
		//;EXINT.C: 83: PORTC |= 1<<5;
		BCR 	STATUS,5 		//001F 	1283
		BSR 	7H,5 			//0020 	1A87

		//;EXINT.C: 84: delayMs(500);
		LDWI 	F4H 			//0021 	2AF4
		LCALL 	41H 			//0022 	3041

		//;EXINT.C: 85: PORTC &= ~(1<<5);
		BCR 	7H,5 			//0023 	1287

		//;EXINT.C: 86: delayMs(500);
		LDWI 	F4H 			//0024 	2AF4
		LCALL 	41H 			//0025 	3041
		LJUMP 	1FH 			//0026 	381F

		//;EXINT.C: 45: if(INTF == 1)
		BTSS 	INTCON,1 		//0027 	1C8B
		LJUMP 	32H 			//0028 	3832

		//;EXINT.C: 46: {
		//;EXINT.C: 47: INTF=0;
		BCR 	INTCON,1 		//0029 	108B

		//;EXINT.C: 49: PORTC |= 1<<4;
		//;EXINT.C: 50: delayMs(100);
		LCALL 	39H 			//002A 	3039
		LCALL 	52H 			//002B 	3052

		//;EXINT.C: 51: PORTC &= ~(1<<4);
		//;EXINT.C: 52: delayMs(100);
		LCALL 	3DH 			//002C 	303D
		LCALL 	52H 			//002D 	3052

		//;EXINT.C: 54: PORTC |= 1<<4;
		//;EXINT.C: 55: delayMs(100);
		LCALL 	39H 			//002E 	3039
		LCALL 	52H 			//002F 	3052

		//;EXINT.C: 56: PORTC &= ~(1<<4);
		//;EXINT.C: 57: delayMs(100);
		LCALL 	3DH 			//0030 	303D
		LCALL 	52H 			//0031 	3052
		LDR 	76H,0 			//0032 	0876
		STR 	PCLATH 			//0033 	018A
		SWAPR 	75H,0 			//0034 	0775
		STR 	STATUS 			//0035 	0183
		SWAPR 	7EH,1 			//0036 	07FE
		SWAPR 	7EH,0 			//0037 	077E
		RETI		 			//0038 	0009
		BCR 	STATUS,5 		//0039 	1283
		BCR 	STATUS,6 		//003A 	1303
		BSR 	7H,4 			//003B 	1A07
		RETW 	64H 			//003C 	2164
		BCR 	STATUS,5 		//003D 	1283
		BCR 	STATUS,6 		//003E 	1303
		BCR 	7H,4 			//003F 	1207
		RETW 	64H 			//0040 	2164
		STR 	22H 			//0041 	01A2

		//;EXINT.C: 26: unsigned char a,b;
		//;EXINT.C: 28: for(b=0;b<5;b++)
		CLRR 	24H 			//0042 	0124

		//;EXINT.C: 29: {
		//;EXINT.C: 30: for(a=0;a<time;a++)
		CLRR 	23H 			//0043 	0123
		LDR 	22H,0 			//0044 	0822
		SUBWR 	23H,0 			//0045 	0C23
		BTSC 	STATUS,0 		//0046 	1403
		LJUMP 	4CH 			//0047 	384C

		//;EXINT.C: 31: {
		//;EXINT.C: 32: delayUs(197);
		LDWI 	C5H 			//0048 	2AC5
		LCALL 	63H 			//0049 	3063
		INCR	23H,1 			//004A 	09A3
		LJUMP 	44H 			//004B 	3844
		LDWI 	5H 			//004C 	2A05
		INCR	24H,1 			//004D 	09A4
		SUBWR 	24H,0 			//004E 	0C24
		BTSC 	STATUS,0 		//004F 	1403
		RET		 					//0050 	0004
		LJUMP 	43H 			//0051 	3843
		STR 	72H 			//0052 	01F2

		//;EXINT.C: 26: unsigned char a,b;
		//;EXINT.C: 28: for(b=0;b<5;b++)
		CLRR 	74H 			//0053 	0174
		LDWI 	5H 			//0054 	2A05
		SUBWR 	74H,0 			//0055 	0C74
		BTSC 	STATUS,0 		//0056 	1403
		RET		 					//0057 	0004

		//;EXINT.C: 29: {
		//;EXINT.C: 30: for(a=0;a<time;a++)
		CLRR 	73H 			//0058 	0173
		LDR 	72H,0 			//0059 	0872
		SUBWR 	73H,0 			//005A 	0C73
		BTSC 	STATUS,0 		//005B 	1403
		LJUMP 	61H 			//005C 	3861

		//;EXINT.C: 31: {
		//;EXINT.C: 32: delayUs(197);
		LDWI 	C5H 			//005D 	2AC5
		LCALL 	6EH 			//005E 	306E
		INCR	73H,1 			//005F 	09F3
		LJUMP 	59H 			//0060 	3859
		INCR	74H,1 			//0061 	09F4
		LJUMP 	54H 			//0062 	3854
		STR 	20H 			//0063 	01A0

		//;EXINT.C: 17: unsigned char a;
		//;EXINT.C: 18: for(a=0;a<time;a++)
		CLRR 	21H 			//0064 	0121
		LDR 	20H,0 			//0065 	0820
		SUBWR 	21H,0 			//0066 	0C21
		BTSC 	STATUS,0 		//0067 	1403
		RET		 					//0068 	0004

		//;EXINT.C: 19: {
		//;EXINT.C: 20: __nop();
		NOP		 					//0069 	0000
		BCR 	STATUS,5 		//006A 	1283
		BCR 	STATUS,6 		//006B 	1303
		INCR	21H,1 			//006C 	09A1
		LJUMP 	65H 			//006D 	3865
		STR 	70H 			//006E 	01F0

		//;EXINT.C: 17: unsigned char a;
		//;EXINT.C: 18: for(a=0;a<time;a++)
		CLRR 	71H 			//006F 	0171
		LDR 	70H,0 			//0070 	0870
		SUBWR 	71H,0 			//0071 	0C71
		BTSC 	STATUS,0 		//0072 	1403
		RET		 					//0073 	0004
		ORG		0074H

		//;EXINT.C: 19: {
		//;EXINT.C: 20: __nop();
		NOP		 					//0074 	0000
		INCR	71H,1 			//0075 	09F1
		LJUMP 	70H 			//0076 	3870
			END
