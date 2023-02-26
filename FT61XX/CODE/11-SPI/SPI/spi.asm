//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//		main@i		EQU		75H
//		delayMs@time		EQU		72H
//		delayMs@b		EQU		74H
//		delayMs@a		EQU		73H
//		delayMs@time		EQU		72H
//		delayMs@time		EQU		72H
//		delayUs@time		EQU		70H
//		delayUs@a		EQU		71H
//		delayUs@time		EQU		70H
//		delayUs@time		EQU		70H
//		SPI_RW@data		EQU		70H
//		SPI_RW@i		EQU		71H
//		SPI_RW@data		EQU		70H
//		SPI_RW@data		EQU		70H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	7FEH 			//0000 	3FFE
		ORG		07A9H
		STR 	70H 			//07A9 	01F0

		//;SPI.C: 18: unsigned char a;
		//;SPI.C: 19: for(a=0;a<time;a++)
		CLRR 	71H 			//07AA 	0171
		LDR 	70H,0 			//07AB 	0870
		SUBWR 	71H,0 			//07AC 	0C71
		BTSC 	STATUS,0 		//07AD 	1403
		RET		 					//07AE 	0004

		//;SPI.C: 20: {
		//;SPI.C: 21: __nop();
		NOP		 					//07AF 	0000
		INCR	71H,1 			//07B0 	09F1
		LJUMP 	7ABH 			//07B1 	3FAB
		STR 	72H 			//07B2 	01F2

		//;SPI.C: 27: unsigned char a,b;
		//;SPI.C: 29: for(b=0;b<5;b++)
		CLRR 	74H 			//07B3 	0174

		//;SPI.C: 30: {
		//;SPI.C: 31: for(a=0;a<time;a++)
		CLRR 	73H 			//07B4 	0173
		LDR 	72H,0 			//07B5 	0872
		SUBWR 	73H,0 			//07B6 	0C73
		BTSC 	STATUS,0 		//07B7 	1403
		LJUMP 	7BDH 			//07B8 	3FBD

		//;SPI.C: 32: {
		//;SPI.C: 33: delayUs(197);
		LDWI 	C5H 			//07B9 	2AC5
		LCALL 	7A9H 			//07BA 	37A9
		INCR	73H,1 			//07BB 	09F3
		LJUMP 	7B5H 			//07BC 	3FB5
		LDWI 	5H 			//07BD 	2A05
		INCR	74H,1 			//07BE 	09F4
		SUBWR 	74H,0 			//07BF 	0C74
		BTSC 	STATUS,0 		//07C0 	1403
		RET		 					//07C1 	0004
		LJUMP 	7B4H 			//07C2 	3FB4

		//;SPI.C: 65: OSCCON = 0B01110001;
		LDWI 	71H 			//07C3 	2A71
		BSR 	STATUS,5 		//07C4 	1A83
		STR 	FH 			//07C5 	018F

		//;SPI.C: 66: PORTA = 0B00000000;
		BCR 	STATUS,5 		//07C6 	1283
		CLRR 	5H 			//07C7 	0105

		//;SPI.C: 67: TRISA = 0B00010000;
		LDWI 	10H 			//07C8 	2A10
		BSR 	STATUS,5 		//07C9 	1A83
		STR 	5H 			//07CA 	0185

		//;SPI.C: 68: WPUA = 0B00010000;
		STR 	15H 			//07CB 	0195

		//;SPI.C: 70: PA7 = 1;
		BCR 	STATUS,5 		//07CC 	1283
		BSR 	5H,7 			//07CD 	1B85

		//;SPI.C: 71: PA6 = 0;
		BCR 	5H,6 			//07CE 	1305

		//;SPI.C: 72: PA2 = 0;
		BCR 	5H,2 			//07CF 	1105

		//;SPI.C: 75: {
		//;SPI.C: 77: for(unsigned char i=0 ; i<255 ; i++)
		CLRR 	75H 			//07D0 	0175

		//;SPI.C: 78: {
		//;SPI.C: 79: PA7=0;
		BCR 	STATUS,5 		//07D1 	1283
		BCR 	STATUS,6 		//07D2 	1303
		BCR 	5H,7 			//07D3 	1385

		//;SPI.C: 80: SPI_RW(0x11);
		LDWI 	11H 			//07D4 	2A11
		LCALL 	7DFH 			//07D5 	37DF

		//;SPI.C: 81: SPI_RW(i);
		LDR 	75H,0 			//07D6 	0875
		LCALL 	7DFH 			//07D7 	37DF

		//;SPI.C: 82: PA7=1;
		BSR 	5H,7 			//07D8 	1B85

		//;SPI.C: 83: delayMs(30);
		LDWI 	1EH 			//07D9 	2A1E
		LCALL 	7B2H 			//07DA 	37B2
		INCR	75H,1 			//07DB 	09F5
		INCRSZ 	75H,0 		//07DC 	0A75
		LJUMP 	7D1H 			//07DD 	3FD1
		LJUMP 	7D0H 			//07DE 	3FD0
		STR 	70H 			//07DF 	01F0

		//;SPI.C: 42: unsigned char i;
		//;SPI.C: 43: for(i=0;i<8;i++)
		CLRR 	71H 			//07E0 	0171

		//;SPI.C: 44: {
		//;SPI.C: 45: if(data&0x80)
		BTSS 	70H,7 			//07E1 	1FF0
		LJUMP 	7E5H 			//07E2 	3FE5

		//;SPI.C: 46: PA2 = 1;
		BSR 	5H,2 			//07E3 	1905
		LJUMP 	7E6H 			//07E4 	3FE6

		//;SPI.C: 47: else
		//;SPI.C: 48: PA2 = 0;
		BCR 	5H,2 			//07E5 	1105

		//;SPI.C: 49: __nop();
		NOP		 					//07E6 	0000

		//;SPI.C: 50: data<<=1;
		BCR 	STATUS,0 		//07E7 	1003
		RLR 	70H,1 			//07E8 	05F0

		//;SPI.C: 51: PA6 = 1;
		BCR 	STATUS,5 		//07E9 	1283
		BCR 	STATUS,6 		//07EA 	1303
		BSR 	5H,6 			//07EB 	1B05

		//;SPI.C: 52: __nop();
		NOP		 					//07EC 	0000

		//;SPI.C: 53: if(PA4)
		BCR 	STATUS,5 		//07ED 	1283
		BCR 	STATUS,6 		//07EE 	1303
		BTSS 	5H,4 			//07EF 	1E05
		LJUMP 	7F3H 			//07F0 	3FF3

		//;SPI.C: 54: data |= 0x01;
		BSR 	70H,0 			//07F1 	1870
		LJUMP 	7F4H 			//07F2 	3FF4

		//;SPI.C: 55: else
		//;SPI.C: 56: data &= 0xFE;
		BCR 	70H,0 			//07F3 	1070

		//;SPI.C: 57: __nop();
		NOP		 					//07F4 	0000

		//;SPI.C: 58: PA6 = 0;
		BCR 	STATUS,5 		//07F5 	1283
		BCR 	STATUS,6 		//07F6 	1303
		BCR 	5H,6 			//07F7 	1305
		LDWI 	8H 			//07F8 	2A08
		ORG		07F9H
		INCR	71H,1 			//07F9 	09F1
		SUBWR 	71H,0 			//07FA 	0C71
		BTSC 	STATUS,0 		//07FB 	1403
		RET		 					//07FC 	0004
		LJUMP 	7E1H 			//07FD 	3FE1
		CLRR 	STATUS 			//07FE 	0103
		LJUMP 	7C3H 			//07FF 	3FC3
			END
