//Deviec:FT61F02X
//-----------------------Variable---------------------------------
		_sec		EQU		77H
//		bcd2bin@x		EQU		75H
//		bcd2bin@bin		EQU		74H
//		bcd2bin@x		EQU		75H
//		bcd2bin@x		EQU		75H
//		___bmul@multiplier		EQU		72H
//		___bmul@product		EQU		71H
//		___bmul@multiplier		EQU		72H
//		___bmul@multiplicand		EQU		70H
//		___bmul@multiplier		EQU		72H
//		IIC_WRITE@address		EQU		76H
//		IIC_WRITE@address		EQU		76H
//		IIC_WRITE@data		EQU		75H
//		IIC_WRITE@address		EQU		76H
//		IIC_READ@address		EQU		75H
//		IIC_READ@iicdata		EQU		76H
//		IIC_READ@address		EQU		75H
//		IIC_READ@address		EQU		75H
//		IIC_Wait_Ack@ucErrTime		EQU		72H
//		IIC_Send_Byte@txd		EQU		73H
//		IIC_Send_Byte@t		EQU		74H
//		IIC_Send_Byte@txd		EQU		73H
//		IIC_Send_Byte@txd		EQU		73H
//		IIC_Read_Byte@i		EQU		73H
//		IIC_Read_Byte@receive		EQU		72H
//		DelayUs@Time		EQU		70H
//		DelayUs@a		EQU		71H
//		DelayUs@Time		EQU		70H
//		DelayUs@Time		EQU		70H
//-----------------------Variable END---------------------------------

		ORG		0000H
		LJUMP 	7FDH 			//0000 	3FFD
		ORG		0703H
		STR 	70H 			//0703 	01F0

		//;I2C.C: 26: unsigned char a;
		//;I2C.C: 27: for(a=0;a<Time;a++)
		CLRR 	71H 			//0704 	0171
		LDR 	70H,0 			//0705 	0870
		SUBWR 	71H,0 			//0706 	0C71
		BTSC 	STATUS,0 		//0707 	1403
		RET		 					//0708 	0004

		//;I2C.C: 28: {
		//;I2C.C: 29: __nop();
		NOP		 					//0709 	0000
		INCR	71H,1 			//070A 	09F1
		LJUMP 	705H 			//070B 	3F05

		//;I2C.C: 16: OSCCON = 0B01110001;
		LDWI 	71H 			//070C 	2A71
		BSR 	STATUS,5 		//070D 	1A83
		STR 	FH 			//070E 	018F

		//;I2C.C: 17: INTCON = 0;
		CLRR 	INTCON 			//070F 	010B

		//;I2C.C: 18: PORTA = 0B00000000;
		BCR 	STATUS,5 		//0710 	1283
		CLRR 	5H 			//0711 	0105

		//;I2C.C: 19: TRISA = 0B00000000;
		BSR 	STATUS,5 		//0712 	1A83
		CLRR 	5H 			//0713 	0105

		//;I2C.C: 20: ANSEL = 0B00000000;
		CLRR 	11H 			//0714 	0111
		RET		 					//0715 	0004
		STR 	75H 			//0716 	01F5

		//;I2C.C: 173: unsigned char bin;
		//;I2C.C: 174: bin=((x & 0xf0)>>4)*10 +(x & 0x0f);
		ANDWI 	FH 			//0717 	240F
		STR 	73H 			//0718 	01F3
		LDWI 	AH 			//0719 	2A0A
		STR 	70H 			//071A 	01F0
		SWAPR 	75H,0 			//071B 	0775
		ANDWI 	FH 			//071C 	240F
		LCALL 	72FH 			//071D 	372F
		ADDWR 	73H,0 			//071E 	0B73
		STR 	74H 			//071F 	01F4

		//;I2C.C: 175: return (bin);
		RET		 					//0720 	0004

		//;I2C.C: 47: TRISA2 = 0;
		//;I2C.C: 48: PA4=0;
		LCALL 	7F3H 			//0721 	37F3

		//;I2C.C: 49: PA2=0;
		BCR 	5H,2 			//0722 	1105

		//;I2C.C: 50: DelayUs(10);
		LDWI 	AH 			//0723 	2A0A
		LCALL 	703H 			//0724 	3703

		//;I2C.C: 51: PA4=1;
		BCR 	STATUS,5 		//0725 	1283
		BCR 	STATUS,6 		//0726 	1303
		BSR 	5H,4 			//0727 	1A05

		//;I2C.C: 52: DelayUs(10);
		LDWI 	AH 			//0728 	2A0A
		LCALL 	703H 			//0729 	3703

		//;I2C.C: 53: PA2=1;
		BCR 	STATUS,5 		//072A 	1283
		BCR 	STATUS,6 		//072B 	1303
		BSR 	5H,2 			//072C 	1905

		//;I2C.C: 54: DelayUs(10);
		LDWI 	AH 			//072D 	2A0A
		LJUMP 	703H 			//072E 	3F03
		STR 	72H 			//072F 	01F2
		CLRR 	71H 			//0730 	0171
		LDR 	70H,0 			//0731 	0870
		BTSC 	72H,0 			//0732 	1472
		ADDWR 	71H,1 			//0733 	0BF1
		BCR 	STATUS,0 		//0734 	1003
		RLR 	70H,1 			//0735 	05F0
		BCR 	STATUS,0 		//0736 	1003
		RRR	72H,1 			//0737 	06F2
		LDR 	72H,0 			//0738 	0872
		BTSS 	STATUS,2 		//0739 	1D03
		LJUMP 	731H 			//073A 	3F31
		LDR 	71H,0 			//073B 	0871
		RET		 					//073C 	0004

		//;I2C.C: 91: PA4=0;
		BCR 	STATUS,5 		//073D 	1283
		BCR 	STATUS,6 		//073E 	1303
		BCR 	5H,4 			//073F 	1205

		//;I2C.C: 92: TRISA2 = 0;
		BSR 	STATUS,5 		//0740 	1A83
		BCR 	5H,2 			//0741 	1105

		//;I2C.C: 93: PA2=1;
		BCR 	STATUS,5 		//0742 	1283
		BSR 	5H,2 			//0743 	1905

		//;I2C.C: 94: DelayUs(5);
		LDWI 	5H 			//0744 	2A05
		LCALL 	703H 			//0745 	3703

		//;I2C.C: 95: PA4=1;
		//;I2C.C: 96: DelayUs(5);
		LCALL 	7F9H 			//0746 	37F9
		LCALL 	703H 			//0747 	3703

		//;I2C.C: 97: PA4=0;
		BCR 	STATUS,5 		//0748 	1283
		BCR 	STATUS,6 		//0749 	1303
		BCR 	5H,4 			//074A 	1205
		RET		 					//074B 	0004

		//;I2C.C: 187: POWER_INITIAL();
		LCALL 	70CH 			//074C 	370C

		//;I2C.C: 189: IIC_WRITE(0x00,0x7f);
		LDWI 	7FH 			//074D 	2A7F
		STR 	75H 			//074E 	01F5
		LDWI 	0H 			//074F 	2A00
		LCALL 	76FH 			//0750 	376F

		//;I2C.C: 190: IIC_WRITE(0x00,0x03);
		LDWI 	3H 			//0751 	2A03
		STR 	75H 			//0752 	01F5
		LDWI 	0H 			//0753 	2A00
		LCALL 	76FH 			//0754 	376F

		//;I2C.C: 191: while(1)
		//;I2C.C: 192: {
		//;I2C.C: 195: sec=IIC_READ(0x00);
		LDWI 	0H 			//0755 	2A00
		LCALL 	79BH 			//0756 	379B
		STR 	77H 			//0757 	01F7

		//;I2C.C: 196: sec=bcd2bin(sec);
		LDR 	77H,0 			//0758 	0877
		LCALL 	716H 			//0759 	3716
		STR 	77H 			//075A 	01F7

		//;I2C.C: 197: __nop();
		NOP		 					//075B 	0000
		LJUMP 	755H 			//075C 	3F55

		//;I2C.C: 35: TRISA2 = 0;
		BSR 	STATUS,5 		//075D 	1A83
		BCR 	STATUS,6 		//075E 	1303
		BCR 	5H,2 			//075F 	1105

		//;I2C.C: 36: PA2=1;
		BCR 	STATUS,5 		//0760 	1283
		BSR 	5H,2 			//0761 	1905

		//;I2C.C: 37: PA4=1;
		BSR 	5H,4 			//0762 	1A05

		//;I2C.C: 38: DelayUs(10);
		LDWI 	AH 			//0763 	2A0A
		LCALL 	703H 			//0764 	3703

		//;I2C.C: 39: PA2=0;
		BCR 	STATUS,5 		//0765 	1283
		BCR 	STATUS,6 		//0766 	1303
		BCR 	5H,2 			//0767 	1105

		//;I2C.C: 40: DelayUs(10);
		LDWI 	AH 			//0768 	2A0A
		LCALL 	703H 			//0769 	3703

		//;I2C.C: 41: PA4=0;
		BCR 	STATUS,5 		//076A 	1283
		BCR 	STATUS,6 		//076B 	1303
		BCR 	5H,4 			//076C 	1205

		//;I2C.C: 42: DelayUs(10);
		LDWI 	AH 			//076D 	2A0A
		LJUMP 	703H 			//076E 	3F03
		STR 	76H 			//076F 	01F6

		//;I2C.C: 157: IIC_WRITE_Begin:
		//;I2C.C: 158: IIC_Start();
		LCALL 	75DH 			//0770 	375D

		//;I2C.C: 159: IIC_Send_Byte(0xd0);
		LDWI 	D0H 			//0771 	2AD0
		LCALL 	7D1H 			//0772 	37D1

		//;I2C.C: 160: if(IIC_Wait_Ack())goto IIC_WRITE_Begin;
		LCALL 	784H 			//0773 	3784
		XORWI 	0H 			//0774 	2600
		BTSS 	STATUS,2 		//0775 	1D03
		LJUMP 	770H 			//0776 	3F70

		//;I2C.C: 162: IIC_Send_Byte(address);
		LDR 	76H,0 			//0777 	0876
		LCALL 	7D1H 			//0778 	37D1

		//;I2C.C: 163: if(IIC_Wait_Ack())goto IIC_WRITE_Begin;
		LCALL 	784H 			//0779 	3784
		XORWI 	0H 			//077A 	2600
		BTSS 	STATUS,2 		//077B 	1D03
		LJUMP 	770H 			//077C 	3F70

		//;I2C.C: 165: IIC_Send_Byte(data);
		LDR 	75H,0 			//077D 	0875
		LCALL 	7D1H 			//077E 	37D1

		//;I2C.C: 166: if(IIC_Wait_Ack())goto IIC_WRITE_Begin;
		LCALL 	784H 			//077F 	3784
		XORWI 	0H 			//0780 	2600
		BTSS 	STATUS,2 		//0781 	1D03
		LJUMP 	770H 			//0782 	3F70

		//;I2C.C: 168: IIC_Stop();
		LJUMP 	721H 			//0783 	3F21

		//;I2C.C: 59: unsigned char ucErrTime=0;
		CLRR 	72H 			//0784 	0172

		//;I2C.C: 60: TRISA2 = 1;
		BSR 	STATUS,5 		//0785 	1A83
		BCR 	STATUS,6 		//0786 	1303
		BSR 	5H,2 			//0787 	1905

		//;I2C.C: 61: PA2=1;
		BCR 	STATUS,5 		//0788 	1283
		BSR 	5H,2 			//0789 	1905

		//;I2C.C: 62: DelayUs(5);
		LDWI 	5H 			//078A 	2A05
		LCALL 	703H 			//078B 	3703

		//;I2C.C: 63: PA4=1;
		//;I2C.C: 64: DelayUs(5);
		LCALL 	7F9H 			//078C 	37F9
		LCALL 	703H 			//078D 	3703

		//;I2C.C: 65: while(PA2)
		BCR 	STATUS,5 		//078E 	1283
		BCR 	STATUS,6 		//078F 	1303
		BTSS 	5H,2 			//0790 	1D05
		LJUMP 	799H 			//0791 	3F99
		LDWI 	FBH 			//0792 	2AFB

		//;I2C.C: 66: {
		//;I2C.C: 67: ucErrTime++;
		INCR	72H,1 			//0793 	09F2

		//;I2C.C: 68: if(ucErrTime>250)
		SUBWR 	72H,0 			//0794 	0C72
		BTSS 	STATUS,0 		//0795 	1C03
		LJUMP 	78EH 			//0796 	3F8E

		//;I2C.C: 69: {
		//;I2C.C: 70: IIC_Stop();
		LCALL 	721H 			//0797 	3721

		//;I2C.C: 71: return 1;
		RETW 	1H 			//0798 	2101

		//;I2C.C: 72: }
		//;I2C.C: 73: }
		//;I2C.C: 74: PA4=0;
		BCR 	5H,4 			//0799 	1205

		//;I2C.C: 75: return 0;
		RETW 	0H 			//079A 	2100
		STR 	75H 			//079B 	01F5

		//;I2C.C: 142: IIC_Start();
		LCALL 	75DH 			//079C 	375D

		//;I2C.C: 143: IIC_Send_Byte(0xd0);
		LDWI 	D0H 			//079D 	2AD0
		LCALL 	7D1H 			//079E 	37D1

		//;I2C.C: 144: if(IIC_Wait_Ack())goto IIC_READ_Begin;
		LCALL 	784H 			//079F 	3784
		XORWI 	0H 			//07A0 	2600
		BTSS 	STATUS,2 		//07A1 	1D03
		LJUMP 	79CH 			//07A2 	3F9C

		//;I2C.C: 145: IIC_Send_Byte(address);
		LDR 	75H,0 			//07A3 	0875
		LCALL 	7D1H 			//07A4 	37D1

		//;I2C.C: 146: if(IIC_Wait_Ack())goto IIC_READ_Begin;
		LCALL 	784H 			//07A5 	3784
		XORWI 	0H 			//07A6 	2600
		BTSS 	STATUS,2 		//07A7 	1D03
		LJUMP 	79CH 			//07A8 	3F9C

		//;I2C.C: 147: IIC_Start();
		LCALL 	75DH 			//07A9 	375D

		//;I2C.C: 148: IIC_Send_Byte(0xd1);
		LDWI 	D1H 			//07AA 	2AD1
		LCALL 	7D1H 			//07AB 	37D1

		//;I2C.C: 149: if(IIC_Wait_Ack())goto IIC_READ_Begin;
		LCALL 	784H 			//07AC 	3784
		XORWI 	0H 			//07AD 	2600
		BTSS 	STATUS,2 		//07AE 	1D03
		LJUMP 	79CH 			//07AF 	3F9C

		//;I2C.C: 150: iicdata=IIC_Read_Byte();
		LCALL 	7B5H 			//07B0 	37B5
		STR 	76H 			//07B1 	01F6

		//;I2C.C: 151: IIC_Stop();
		LCALL 	721H 			//07B2 	3721

		//;I2C.C: 152: return iicdata;
		LDR 	76H,0 			//07B3 	0876
		RET		 					//07B4 	0004

		//;I2C.C: 122: unsigned char i,receive=0;
		CLRR 	72H 			//07B5 	0172

		//;I2C.C: 123: TRISA2 = 1;
		BSR 	STATUS,5 		//07B6 	1A83
		BCR 	STATUS,6 		//07B7 	1303
		BSR 	5H,2 			//07B8 	1905

		//;I2C.C: 124: for(i=0;i<8;i++ )
		CLRR 	73H 			//07B9 	0173

		//;I2C.C: 125: {
		//;I2C.C: 126: PA4=0;
		//;I2C.C: 127: DelayUs(5);
		LCALL 	7CDH 			//07BA 	37CD
		LCALL 	703H 			//07BB 	3703

		//;I2C.C: 128: PA4=1;
		BCR 	STATUS,5 		//07BC 	1283
		BCR 	STATUS,6 		//07BD 	1303
		BSR 	5H,4 			//07BE 	1A05

		//;I2C.C: 129: receive<<=1;
		BCR 	STATUS,0 		//07BF 	1003
		RLR 	72H,1 			//07C0 	05F2

		//;I2C.C: 130: if(PA2)receive++;
		BTSC 	5H,2 			//07C1 	1505
		INCR	72H,1 			//07C2 	09F2

		//;I2C.C: 131: DelayUs(5);
		LDWI 	5H 			//07C3 	2A05
		LCALL 	703H 			//07C4 	3703
		LDWI 	8H 			//07C5 	2A08
		INCR	73H,1 			//07C6 	09F3
		SUBWR 	73H,0 			//07C7 	0C73
		BTSS 	STATUS,0 		//07C8 	1C03
		LJUMP 	7BAH 			//07C9 	3FBA

		//;I2C.C: 132: }
		//;I2C.C: 133: IIC_NAck();
		LCALL 	73DH 			//07CA 	373D

		//;I2C.C: 135: return receive;
		LDR 	72H,0 			//07CB 	0872
		RET		 					//07CC 	0004
		BCR 	STATUS,5 		//07CD 	1283
		BCR 	STATUS,6 		//07CE 	1303
		BCR 	5H,4 			//07CF 	1205
		RETW 	5H 			//07D0 	2105
		STR 	73H 			//07D1 	01F3

		//;I2C.C: 102: unsigned char t;
		//;I2C.C: 103: TRISA2 = 0;
		//;I2C.C: 104: PA4=0;
		LCALL 	7F3H 			//07D2 	37F3

		//;I2C.C: 105: for(t=0;t<8;t++)
		CLRR 	74H 			//07D3 	0174

		//;I2C.C: 106: {
		//;I2C.C: 107: if((txd&0x80)>>7)
		LDR 	73H,0 			//07D4 	0873
		STR 	72H 			//07D5 	01F2
		LDWI 	7H 			//07D6 	2A07
		BCR 	STATUS,0 		//07D7 	1003
		RRR	72H,1 			//07D8 	06F2
		ADDWI 	FFH 			//07D9 	27FF
		BTSS 	STATUS,2 		//07DA 	1D03
		LJUMP 	7D7H 			//07DB 	3FD7
		BTSS 	72H,0 			//07DC 	1C72
		LJUMP 	7E2H 			//07DD 	3FE2

		//;I2C.C: 108: PA2=1;
		BCR 	STATUS,5 		//07DE 	1283
		BCR 	STATUS,6 		//07DF 	1303
		BSR 	5H,2 			//07E0 	1905
		LJUMP 	7E5H 			//07E1 	3FE5

		//;I2C.C: 109: else
		//;I2C.C: 110: PA2=0;
		BCR 	STATUS,5 		//07E2 	1283
		BCR 	STATUS,6 		//07E3 	1303
		BCR 	5H,2 			//07E4 	1105
		LDWI 	5H 			//07E5 	2A05

		//;I2C.C: 111: txd<<=1;
		BCR 	STATUS,0 		//07E6 	1003
		RLR 	73H,1 			//07E7 	05F3

		//;I2C.C: 112: DelayUs(5);
		LCALL 	703H 			//07E8 	3703

		//;I2C.C: 113: PA4=1;
		//;I2C.C: 114: DelayUs(5);
		LCALL 	7F9H 			//07E9 	37F9
		LCALL 	703H 			//07EA 	3703

		//;I2C.C: 115: PA4=0;
		//;I2C.C: 116: DelayUs(5);
		LCALL 	7CDH 			//07EB 	37CD
		LCALL 	703H 			//07EC 	3703
		LDWI 	8H 			//07ED 	2A08
		INCR	74H,1 			//07EE 	09F4
		SUBWR 	74H,0 			//07EF 	0C74
		BTSC 	STATUS,0 		//07F0 	1403
		RET		 					//07F1 	0004
		LJUMP 	7D4H 			//07F2 	3FD4
		BSR 	STATUS,5 		//07F3 	1A83
		BCR 	STATUS,6 		//07F4 	1303
		BCR 	5H,2 			//07F5 	1105
		BCR 	STATUS,5 		//07F6 	1283
		BCR 	5H,4 			//07F7 	1205
		RET		 					//07F8 	0004
		BCR 	STATUS,5 		//07F9 	1283
		BCR 	STATUS,6 		//07FA 	1303
		ORG		07FBH
		BSR 	5H,4 			//07FB 	1A05
		RETW 	5H 			//07FC 	2105
		CLRR 	77H 			//07FD 	0177
		CLRR 	STATUS 			//07FE 	0103
		LJUMP 	74CH 			//07FF 	3F4C
			END
