//Deviec:FT61F02X
//-----------------------Variable---------------------------------
		_test		EQU		74H
//		EEPROMwrite@EEAddr		EQU		73H
//		EEPROMwrite@EEAddr		EQU		73H
//		EEPROMwrite@data		EQU		72H
//		EEPROMwrite@EEAddr		EQU		73H
//		EEPROMread@EEAddr		EQU		72H
//		EEPROMread@read		EQU		73H
//		EEPROMread@EEAddr		EQU		72H
//		EEPROMread@EEAddr		EQU		72H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	0AH 			//0000 	380A
		ORG		0004H
		STR 	7EH 			//0004 	01FE
		SWAPR 	STATUS,0 		//0005 	0703
		STR 	70H 			//0006 	01F0
		LDR 	PCLATH,0 		//0007 	080A
		STR 	71H 			//0008 	01F1
		LJUMP 	2DH 			//0009 	382D
		LJUMP 	0BH 			//000A 	380B
		CLRR 	74H 			//000B 	0174
		CLRR 	STATUS 			//000C 	0103
		LJUMP 	21H 			//000D 	3821
		STR 	73H 			//000E 	01F3

		//;EEPROM.C: 29: GIE = 0;
		BCR 	INTCON,7 		//000F 	138B

		//;EEPROM.C: 30: while(GIE);
		BTSC 	INTCON,7 		//0010 	178B
		LJUMP 	10H 			//0011 	3810

		//;EEPROM.C: 31: EEADR = EEAddr;
		LDR 	73H,0 			//0012 	0873
		STR 	1BH 			//0013 	019B

		//;EEPROM.C: 32: EEDAT = data;
		LDR 	72H,0 			//0014 	0872
		STR 	1AH 			//0015 	019A

		//;EEPROM.C: 33: EEIF = 0;
		BCR 	STATUS,5 		//0016 	1283
		BCR 	CH,7 			//0017 	138C

		//;EEPROM.C: 34: WREN1 = 1;
		BSR 	STATUS,5 		//0018 	1A83
		BSR 	1CH,2 			//0019 	191C

		//;EEPROM.C: 35: WREN2 = 1;
		BSR 	1CH,4 			//001A 	1A1C

		//;EEPROM.C: 36: WREN3 = 1;
		BSR 	1CH,5 			//001B 	1A9C

		//;EEPROM.C: 37: WR = 1;
		BSR 	1DH,0 			//001C 	181D

		//;EEPROM.C: 38: while (WR);
		BTSC 	1DH,0 			//001D 	141D
		LJUMP 	1DH 			//001E 	381D

		//;EEPROM.C: 39: GIE = 1;
		BSR 	INTCON,7 		//001F 	1B8B
		RET		 					//0020 	0004

		//;EEPROM.C: 66: OSCCON = 0B01110001;
		LDWI 	71H 			//0021 	2A71
		BSR 	STATUS,5 		//0022 	1A83
		STR 	FH 			//0023 	018F

		//;EEPROM.C: 68: EEPROMwrite(0x12,0x55);
		LDWI 	55H 			//0024 	2A55
		STR 	72H 			//0025 	01F2
		LDWI 	12H 			//0026 	2A12
		LCALL 	EH 			//0027 	300E

		//;EEPROM.C: 69: test = EEPROMread(0x12);
		LDWI 	12H 			//0028 	2A12
		LCALL 	34H 			//0029 	3034
		STR 	74H 			//002A 	01F4

		//;EEPROM.C: 71: {
		//;EEPROM.C: 72: __nop();
		NOP		 					//002B 	0000
		LJUMP 	2BH 			//002C 	382B
		LDR 	71H,0 			//002D 	0871
		STR 	PCLATH 			//002E 	018A
		SWAPR 	70H,0 			//002F 	0770
		STR 	STATUS 			//0030 	0183
		SWAPR 	7EH,1 			//0031 	07FE
		SWAPR 	7EH,0 			//0032 	077E
		RETI		 			//0033 	0009
		ORG		0034H
		STR 	72H 			//0034 	01F2

		//;EEPROM.C: 17: unsigned char read;
		//;EEPROM.C: 19: EEADR = EEAddr;
		STR 	1BH 			//0035 	019B

		//;EEPROM.C: 20: RD = 1;
		BSR 	1CH,0 			//0036 	181C

		//;EEPROM.C: 21: read = EEDAT;
		LDR 	1AH,0 			//0037 	081A
		STR 	73H 			//0038 	01F3

		//;EEPROM.C: 22: return read;
		RET		 					//0039 	0004
			END
