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
		LJUMP 	0DH 			//0009 	380D
		LJUMP 	0BH 			//000A 	380B
		CLRR 	STATUS 			//000B 	0103
		LJUMP 	0AH 			//000C 	380A
		LDR 	71H,0 			//000D 	0871
		STR 	PCLATH 			//000E 	018A
		SWAPR 	70H,0 			//000F 	0770
		STR 	STATUS 			//0010 	0183
		SWAPR 	7EH,1 			//0011 	07FE
		SWAPR 	7EH,0 			//0012 	077E
		RETI		 			//0013 	0009
		ORG		0014H
		LJUMP 	0AH 			//0014 	380A
			END
