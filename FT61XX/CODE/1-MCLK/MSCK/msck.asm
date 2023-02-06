//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//		delayUs@time		EQU		72H
//		delayUs@a		EQU		73H
//		delayUs@time		EQU		72H
//		delayUs@time		EQU		72H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	70H 			//0006 	01F0
		LDR 	PCLATH,0 		//0007 	080A
		STR 	71H 			//0008 	01F1
		LJUMP 	27H 			//0009 	3827
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0DH 			//000C 	380D

		//;MSCK.C: 39: OSCCON = 0B01100001;
		LDWI 	61H 			//000D 	2A61
		BSR 	STATUS,5 		//000E 	1A83
		STR 	FH 			//000F 	018F

		//;MSCK.C: 41: TRISC = 0;
		CLRR 	7H 			//0010 	0107

		//;MSCK.C: 42: PORTC = 0;
		BCR 	STATUS,5 		//0011 	1283
		CLRR 	7H 			//0012 	0107

		//;MSCK.C: 45: {
		//;MSCK.C: 46: PORTC |= 1<<5;
		BCR 	STATUS,5 		//0013 	1283
		BCR 	STATUS,6 		//0014 	1303
		BSR 	7H,5 			//0015 	1A87

		//;MSCK.C: 47: delayUs(100);
		LDWI 	64H 			//0016 	2A64
		LCALL 	1EH 			//0017 	301E

		//;MSCK.C: 48: PORTC &= ~(1<<5);
		BCR 	STATUS,5 		//0018 	1283
		BCR 	STATUS,6 		//0019 	1303
		BCR 	7H,5 			//001A 	1287

		//;MSCK.C: 49: delayUs(100);
		LDWI 	64H 			//001B 	2A64
		LCALL 	1EH 			//001C 	301E
		LJUMP 	13H 			//001D 	3813
		STR 	72H 			//001E 	01F2

		//;MSCK.C: 26: unsigned char a;
		//;MSCK.C: 27: for(a=0;a<time;a++)
		CLRR 	73H 			//001F 	0173
		LDR 	72H,0 			//0020 	0872
		SUBWR 	73H,0 			//0021 	0C73
		BTSC 	STATUS,0 		//0022 	1403
		RET		 					//0023 	0004

		//;MSCK.C: 28: {
		//;MSCK.C: 29: __nop();
		NOP		 					//0024 	0000
		INCR	73H,1 			//0025 	09F3
		LJUMP 	20H 			//0026 	3820
		LDR 	71H,0 			//0027 	0871
		STR 	PCLATH 			//0028 	018A
		SWAPR 	70H,0 			//0029 	0770
		STR 	STATUS 			//002A 	0183
		SWAPR 	7EH,1 			//002B 	07FE
		ORG		002CH
		SWAPR 	7EH,0 			//002C 	077E
		RETI		 			//002D 	0009
			END
