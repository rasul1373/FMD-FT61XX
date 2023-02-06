//Deviec:FT61F02X
//-----------------------Variable---------------------------------
//		get_adc@ch		EQU		77H
//		get_adc@adc_data		EQU		78H
//		get_adc@ADCON0buff		EQU		7AH
//		get_adc@ch		EQU		77H
//		get_adc@ch		EQU		77H
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
		LJUMP 	6DH 			//0009 	386D
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0DH 			//000C 	380D

		//;ADC.C: 58: OSCCON = 0B01110001;
		LDWI 	71H 			//000D 	2A71
		BSR 	STATUS,5 		//000E 	1A83
		STR 	FH 			//000F 	018F

		//;ADC.C: 59: TRISC4=1;
		BSR 	7H,4 			//0010 	1A07

		//;ADC.C: 60: PWM3CR0 = 0B00110010;
		LDWI 	32H 			//0011 	2A32
		BCR 	STATUS,5 		//0012 	1283
		BSR 	STATUS,6 		//0013 	1B03
		STR 	FH 			//0014 	018F

		//;ADC.C: 61: PWM3CR1 = 0B10000000;
		LDWI 	80H 			//0015 	2A80
		STR 	10H 			//0016 	0190

		//;ADC.C: 62: TMR3L=0;
		CLRR 	CH 			//0017 	010C

		//;ADC.C: 63: TMR3H=0;
		CLRR 	DH 			//0018 	010D

		//;ADC.C: 64: T3CKDIV=25;
		LDWI 	19H 			//0019 	2A19
		STR 	11H 			//001A 	0191

		//;ADC.C: 65: PR3L=0;
		CLRR 	EH 			//001B 	010E

		//;ADC.C: 66: PR3H0=0;
		BCR 	DH,0 			//001C 	100D

		//;ADC.C: 67: PR3H1=0;
		BCR 	DH,1 			//001D 	108D

		//;ADC.C: 68: PR3H2=0;
		BCR 	DH,2 			//001E 	110D

		//;ADC.C: 69: PR3H3=0;
		BCR 	DH,3 			//001F 	118D

		//;ADC.C: 70: TRISC4=0;
		BSR 	STATUS,5 		//0020 	1A83
		BCR 	STATUS,6 		//0021 	1303
		BCR 	7H,4 			//0022 	1207

		//;ADC.C: 71: TMR3ON=1;
		BCR 	STATUS,5 		//0023 	1283
		BSR 	STATUS,6 		//0024 	1B03
		BSR 	10H,2 			//0025 	1910

		//;ADC.C: 73: ANSEL=0B00000100;
		LDWI 	4H 			//0026 	2A04
		BSR 	STATUS,5 		//0027 	1A83
		BCR 	STATUS,6 		//0028 	1303
		STR 	11H 			//0029 	0191

		//;ADC.C: 74: ADCON1=0B01100000;
		LDWI 	60H 			//002A 	2A60
		STR 	1FH 			//002B 	019F

		//;ADC.C: 75: ADCON0=0B10001001;
		LDWI 	89H 			//002C 	2A89
		BCR 	STATUS,5 		//002D 	1283
		STR 	1FH 			//002E 	019F

		//;ADC.C: 79: {
		//;ADC.C: 80: PR3L = get_adc(2)>>2;
		LDWI 	2H 			//002F 	2A02
		LCALL 	41H 			//0030 	3041
		LDR 	74H,0 			//0031 	0874
		BCR 	STATUS,5 		//0032 	1283
		STR 	20H 			//0033 	01A0
		LDR 	75H,0 			//0034 	0875
		STR 	21H 			//0035 	01A1
		BCR 	STATUS,0 		//0036 	1003
		RRR	21H,1 			//0037 	06A1
		RRR	20H,1 			//0038 	06A0
		BCR 	STATUS,0 		//0039 	1003
		RRR	21H,1 			//003A 	06A1
		RRR	20H,1 			//003B 	06A0
		LDR 	20H,0 			//003C 	0820
		BSR 	STATUS,6 		//003D 	1B03
		STR 	EH 			//003E 	018E

		//;ADC.C: 81: __nop();
		NOP		 					//003F 	0000
		LJUMP 	2FH 			//0040 	382F
		STR 	77H 			//0041 	01F7

		//;ADC.C: 28: ADCON0buff = ADCON0 & 0B11100011;
		BCR 	STATUS,5 		//0042 	1283
		BCR 	STATUS,6 		//0043 	1303
		LDR 	1FH,0 			//0044 	081F
		STR 	7AH 			//0045 	01FA
		LDWI 	E3H 			//0046 	2AE3
		ANDWR 	7AH,1 			//0047 	02FA

		//;ADC.C: 29: ch <<=2;
		BCR 	STATUS,0 		//0048 	1003
		RLR 	77H,1 			//0049 	05F7
		BCR 	STATUS,0 		//004A 	1003
		RLR 	77H,1 			//004B 	05F7

		//;ADC.C: 30: ADCON0buff |= ch;
		LDR 	77H,0 			//004C 	0877
		IORWR 	7AH,1 			//004D 	03FA

		//;ADC.C: 31: ADCON0 = ADCON0buff;
		LDR 	7AH,0 			//004E 	087A
		STR 	1FH 			//004F 	019F

		//;ADC.C: 32: delayUs(20);
		LDWI 	14H 			//0050 	2A14
		LCALL 	64H 			//0051 	3064

		//;ADC.C: 33: GO_DONE=1;
		BCR 	STATUS,5 		//0052 	1283
		BCR 	STATUS,6 		//0053 	1303
		BSR 	1FH,1 			//0054 	189F

		//;ADC.C: 34: while(GO_DONE ==1);
		BTSC 	1FH,1 			//0055 	149F
		LJUMP 	55H 			//0056 	3855

		//;ADC.C: 36: adc_data = ADRESH;
		LDR 	1EH,0 			//0057 	081E
		STR 	78H 			//0058 	01F8
		CLRR 	79H 			//0059 	0179

		//;ADC.C: 37: adc_data <<=8 ;
		STR 	79H 			//005A 	01F9
		CLRR 	78H 			//005B 	0178

		//;ADC.C: 38: adc_data |= ADRESL;
		BSR 	STATUS,5 		//005C 	1A83
		LDR 	1EH,0 			//005D 	081E
		IORWR 	78H,1 			//005E 	03F8

		//;ADC.C: 40: return adc_data;
		LDR 	79H,0 			//005F 	0879
		STR 	75H 			//0060 	01F5
		LDR 	78H,0 			//0061 	0878
		STR 	74H 			//0062 	01F4
		RET		 					//0063 	0004
		STR 	72H 			//0064 	01F2

		//;ADC.C: 16: unsigned char a;
		//;ADC.C: 17: for(a=0;a<time;a++)
		CLRR 	73H 			//0065 	0173
		LDR 	72H,0 			//0066 	0872
		SUBWR 	73H,0 			//0067 	0C73
		BTSC 	STATUS,0 		//0068 	1403
		RET		 					//0069 	0004

		//;ADC.C: 18: {
		//;ADC.C: 19: __nop();
		NOP		 					//006A 	0000
		INCR	73H,1 			//006B 	09F3
		LJUMP 	66H 			//006C 	3866
		LDR 	71H,0 			//006D 	0871
		STR 	PCLATH 			//006E 	018A
		SWAPR 	70H,0 			//006F 	0770
		STR 	STATUS 			//0070 	0183
		SWAPR 	7EH,1 			//0071 	07FE
		SWAPR 	7EH,0 			//0072 	077E
		RETI		 			//0073 	0009
			END
