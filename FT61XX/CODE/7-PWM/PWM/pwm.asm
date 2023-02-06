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
		LJUMP 	27H 			//0009 	3827
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0DH 			//000C 	380D

		//;PWM.C: 30: OSCCON = 0B01110001;
		LDWI 	71H 			//000D 	2A71
		BSR 	STATUS,5 		//000E 	1A83
		STR 	FH 			//000F 	018F

		//;PWM.C: 31: TRISC4=1;
		BSR 	7H,4 			//0010 	1A07

		//;PWM.C: 32: PWM3CR0 = 0B01110010;
		LDWI 	72H 			//0011 	2A72
		BCR 	STATUS,5 		//0012 	1283
		BSR 	STATUS,6 		//0013 	1B03
		STR 	FH 			//0014 	018F

		//;PWM.C: 33: PWM3CR1 = 0B10000000;
		LDWI 	80H 			//0015 	2A80
		STR 	10H 			//0016 	0190

		//;PWM.C: 34: TMR3L=0;
		CLRR 	CH 			//0017 	010C

		//;PWM.C: 35: TMR3H=0;
		CLRR 	DH 			//0018 	010D

		//;PWM.C: 36: T3CKDIV=0;
		CLRR 	11H 			//0019 	0111

		//;PWM.C: 37: PR3L=0;
		CLRR 	EH 			//001A 	010E

		//;PWM.C: 38: PR3H0=0;
		BCR 	DH,0 			//001B 	100D

		//;PWM.C: 39: PR3H1=0;
		BCR 	DH,1 			//001C 	108D

		//;PWM.C: 40: PR3H2=1;
		BSR 	DH,2 			//001D 	190D

		//;PWM.C: 41: PR3H3=0;
		BCR 	DH,3 			//001E 	118D

		//;PWM.C: 42: TRISC4=0;
		BSR 	STATUS,5 		//001F 	1A83
		BCR 	STATUS,6 		//0020 	1303
		BCR 	7H,4 			//0021 	1207

		//;PWM.C: 43: TMR3ON=1;
		BCR 	STATUS,5 		//0022 	1283
		BSR 	STATUS,6 		//0023 	1B03
		BSR 	10H,2 			//0024 	1910

		//;PWM.C: 46: {
		//;PWM.C: 47: __nop();
		NOP		 					//0025 	0000
		LJUMP 	25H 			//0026 	3825
		LDR 	71H,0 			//0027 	0871
		STR 	PCLATH 			//0028 	018A
		SWAPR 	70H,0 			//0029 	0770
		STR 	STATUS 			//002A 	0183
		SWAPR 	7EH,1 			//002B 	07FE
		ORG		002CH
		SWAPR 	7EH,0 			//002C 	077E
		RETI		 			//002D 	0009
			END
