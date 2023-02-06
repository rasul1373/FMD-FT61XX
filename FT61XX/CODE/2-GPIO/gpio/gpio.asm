//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	70H 			//0006 	01F0
		LDR 	PCLATH,0 		//0007 	080A
		STR 	71H 			//0008 	01F1
		LJUMP 	23H 			//0009 	3823
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0DH 			//000C 	380D

		//;gpio.C: 30: OSCCON = 0B01110001;
		LDWI 	71H 			//000D 	2A71
		BSR 	STATUS,5 		//000E 	1A83
		STR 	FH 			//000F 	018F

		//;gpio.C: 32: TRISC = 1<<4;
		LDWI 	10H 			//0010 	2A10
		STR 	7H 			//0011 	0187

		//;gpio.C: 33: WPUC = 1<<4;
		STR 	8H 			//0012 	0188

		//;gpio.C: 34: PORTC = 0;
		BCR 	STATUS,5 		//0013 	1283
		CLRR 	7H 			//0014 	0107
		LJUMP 	17H 			//0015 	3817

		//;gpio.C: 39: {
		//;gpio.C: 40: PORTC |= 1<<5;
		BSR 	7H,5 			//0016 	1A87

		//;gpio.C: 41: }
		//;gpio.C: 37: {
		//;gpio.C: 38: if( (PORTC & 1<<4) >>4 )
		LDR 	7H,0 			//0017 	0807
		STR 	72H 			//0018 	01F2
		LDWI 	4H 			//0019 	2A04
		BCR 	STATUS,0 		//001A 	1003
		RRR	72H,1 			//001B 	06F2
		ADDWI 	FFH 			//001C 	27FF
		BTSS 	STATUS,2 		//001D 	1D03
		LJUMP 	1AH 			//001E 	381A
		BTSC 	72H,0 			//001F 	1472
		LJUMP 	16H 			//0020 	3816

		//;gpio.C: 42: else
		//;gpio.C: 43: {
		//;gpio.C: 44: PORTC &= ~(1<<5);
		BCR 	7H,5 			//0021 	1287
		LJUMP 	17H 			//0022 	3817
		LDR 	71H,0 			//0023 	0871
		ORG		0024H
		STR 	PCLATH 			//0024 	018A
		SWAPR 	70H,0 			//0025 	0770
		STR 	STATUS 			//0026 	0183
		SWAPR 	7EH,1 			//0027 	07FE
		SWAPR 	7EH,0 			//0028 	077E
		RETI		 			//0029 	0009
			END
