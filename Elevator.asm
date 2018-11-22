.nolist
.include "m128def.inc"	 ; ATmega128 definition file
.list

.cseg	.org	0x0000

START:LDI	AH,high(RAMEND)		 
	LDI	AL,low(RAMEND)
	OUT	SPH,AH
	OUT	SPL,AL

	CALL	INIT_MCU		;�ް� 128�� �� ��Ʈ�� ���� ��
	CALL	INIT_COM		;�ø�����Ʈ �ʱ�ȭ �Լ� ȣ��.	

START2:		
;********** ���� ���α׷� *********************************************

MAIN:	CALL	DISP1		;ù ������  1������.

;---------1��-------------------------------------------------------

F1:	CALL	PUSHS		;��ư �Լ� ȣ��.	
	CBI	PORTC,3	;1��LED�� �ҵ�
	CALL	FLAG		;Ÿ �� �÷��� ���� üũ.
	SBIS	PORTA,2	;��ư���� �÷��� üũ�ؼ� ������ ��ŵ...
	JMP	F1		;������ F1�� �б�. 
	
	CALL	D10MS
	DEC	R20		;Ÿ�̸� ����.		
	BRNE	F1		
	
;--------- 2�� -----------------------------------------------------	
UP2:	CALL	UP		;���.
	CALL	DISP2		;2��  
	SBIS	PORTC,4	;2�� �÷��� ��Ʈ �̸� ��ŵ. 	
	JMP	UP3		;�ƴϸ� 3������ ���.
			
F2:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.
	
	CALL	PUSHS 	;2���� ���缭 �� ���� �� �����Լ�ȣ��.
	CBI	PORTC,4	;2��LED�� �ҵ�.	
	CALL	FLAG		;Ÿ �� �÷��� ���� üũ.
	SBIS	PORTA,2	;��ư���� �÷��� üũ�ؼ� ������ ��ŵ ...
	JMP	F2		;������ F2�� �б�. 
	
	CALL	D10MS
	DEC	R20		;Ÿ�̸� ����.
	BRNE	F2		
	
	SBIC	PORTC,7	;5��?  
	JMP	UP3
	SBIC	PORTC,6	;4��?
	JMP	UP3
	SBIC	PORTC,5	;3��?.
	JMP	UP3
	SBIC	PORTC,3	;1��?  
	JMP	DOWN1

;--------------3��------------------------------------------------

UP3:	CALL	UP		;���.
	CALL	DISP3		;3��  
	SBIS	PORTC,5	;3�� �÷��� ��Ʈ �̸� ��ŵ. 	
	JMP	UP4		;�ƴϸ� 4������ ���.
	
F3:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.
	
	CALL	PUSHS 
	CBI	PORTC,5	;3��LED�� �ҵ�. 
	CALL	FLAG		;���� �÷��� ���� üũ.
	SBIS	PORTA,2	;���� �÷��� üũ�ؼ�...
	JMP	F3		;������ F3 �� �б�. 
	
	CALL	D10MS
	DEC	R20		
	BRNE	F3		
	
	SBIC	PORTC,7	;5?
	JMP	UP4
	SBIC	PORTC,6	;4?
	JMP	UP4
	SBIC	PORTC,4	;2?
	JMP	DOWN2
	SBIC	PORTC,3	;1?
	JMP	DOWN2

;----------- 4�� ---------------------------------------------------

UP4:	CALL	UP
	CALL	DISP4		;4��  
	SBIS	PORTC,6	;4�� �÷��� ��Ʈ �̸� ��ŵ. 	
	JMP	UP5
	
F4:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.
	
	CALL	PUSHS 
	CBI	PORTC,6	;4��LED�� �ҵ�. 
	CALL	FLAG		;���� �÷��� ���� üũ.
	SBIS	PORTA,2	;���� �÷��� üũ�ؼ�...
	JMP	F4		;������ F4�� �б�.(���ѹݺ�)
	
	CALL	D10MS
	DEC	R20		
	BRNE	F4		
	 
	SBIC	PORTC,7
	JMP	UP5
	SBIC	PORTC,5
	JMP	DOWN3
	SBIC	PORTC,4
	JMP	DOWN3
	SBIC	PORTC,3		 
	JMP	DOWN3
 
;------------ 5�� ------------------------------------------------

UP5:	CALL	UP
	CALL	DISP5		;5		
		
F5:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.
	
	CALL	PUSHS 
	CBI	PORTC,7	;5 LED�� �ҵ�. 
	CALL	FLAG		;���� �÷��� ���� üũ.
	SBIS	PORTA,2	;���� �÷��� üũ�ؼ�...
	JMP	F5		;������ F5 �� �б�. 
	
	CALL	D10MS
	DEC	R20		
	BRNE	F5		
	 
;--------------------4��  ------------------------------------------

DOWN4:CALL	DOWN
	CALL	DISP4
	SBIS	PORTC,6	;4�� �÷���?
	JMP	DOWN3
	
FD4:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.

	CALL	PUSHS	
	CBI	PORTC,6	;�ش� ��LED�� �ҵ�
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD4		;������ FD4�� �б�. 
	
	CALL	D10MS
	DEC	R20		;Ÿ�̸� ����.
	BRNE	FD4		
	
	SBIC	PORTC,3	;1?
	JMP	DOWN3
	SBIC	PORTC,4	;2?
	JMP	DOWN3
	SBIC	PORTC,5	;3?
	JMP	DOWN3
	SBIC	PORTC,7	;5?
	JMP	UP5	

;---------------- 3�� ---------------------------------------------

DOWN3:CALL	DOWN
	CALL	DISP3
	SBIS	PORTC,5	;3�� �÷���?
	JMP	DOWN2		

FD3:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.

	CALL	PUSHS	
	CBI	PORTC,5	;3��LED�� �ҵ�
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD3		;������ FD3 �б�. 
	
	CALL	D10MS
	DEC	R20		;Ÿ�̸� ����.
	BRNE	FD3		
	
	SBIC	PORTC,3	;1?
	JMP	DOWN2
	SBIC	PORTC,4	;2?
	JMP	DOWN2
	SBIC	PORTC,6	;4?
	JMP	UP4
	SBIC	PORTC,7	;5?
	JMP	UP4	
		
;--------------------- 2�� -----------------------------------------

DOWN2:CALL	DOWN
	CALL	DISP2
	SBIS	PORTC,4	;2�� �÷���? 
	JMP	DOWN1

FD2:	SBIS	PINA,1		;���� ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	BLINE		;������ ��ŵ ���ϰ� BLINE�� �б�.

	CALL	PUSHS	
	CBI	PORTC,4	;2 LED�� �ҵ�
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD2		;������ FD2 �б�. 
	
	CALL	D10MS
	DEC	R20		;Ÿ�̸� ����.
	BRNE	FD2		
	
	SBIC	PORTC,3	;1? 
	JMP	DOWN1
	SBIC	PORTC,5	;3?
	JMP	UP3
	SBIC	PORTC,6	;4?
	JMP	UP3
	SBIC	PORTC,7	;5?
	JMP	UP3		
	
DOWN1:CALL	DOWN	
	JMP	MAIN		;ó������ ���ư�.
	
;************* ���� �� ***************************************************
;-----------�����Լ�  ----------------------------------------------- 

VOICE:	IN	AL,PINC	;���� ����� �о� �ͼ�......	
	CPI	AL,0B00000110	;1�ΰ��� ���ؼ�...
	BRNE	NEXT1		;�ƴϸ� NEXT1�� �귻ġ��.
	JMP	SW1
	
NEXT1:CPI	AL,0B00000101	;2 �ΰ�.
	BRNE	NEXT2		 
	JMP	SW2
	
NEXT2:CPI	AL,0B00000100	;3�ΰ�
	BRNE	NEXT3
	JMP	SW3
	
NEXT3:CPI	AL,0B00000011	;4�ΰ�?
	BRNE	NEXT4
	JMP	SW4
	
NEXT4:CPI	AL,0B00000010	;5 �ΰ�?
	BRNE	NEXT5
	JMP	SW5	
NEXT5:RET	

;----------- ��ư�����Լ�  -------------------------------------------

PUSHS:CALL	DANGER	;������ ������ ��Ȯ�� ������� üũ. 

PUSHSS:CALL	VOICE		  
 
	SBIS	PINA,3		;1 ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	SW1		
 	SBIS	PINA,4		;2 ����ġ�� ������ ������ ���� ��� ��ŵ.
	JMP	SW2		
	SBIS	PINA,5		;3 ����ġ ?
	JMP	SW3		
	SBIS	PINA,6		;4 ����ġ ?
	JMP	SW4		
	SBIS	PINA,7		;5 ����ġ ?
	JMP	SW5	
	RET			
	
SW1:  SBI	PORTC,3	;1�� LED ON
	CALL	FLSW
	RET
SW2:  SBI	PORTC,4	;2�� LED ON
	CALL	FLSW
	RET
SW3:  SBI	PORTC,5	;3�� LED ON
	CALL	FLSW
	RET
SW4:  SBI	PORTC,6	;4�� LED ON
	CALL	FLSW
	RET
SW5:  SBI	PORTC,7	;5�� LED ON
	CALL	FLSW
	RET
	
FLSW:	SBI	PORTA,2		
	RET

FLAG:	IN	AH,PORTC		
	CPI	AH,0B00000000	;0�ΰ��� ���ؼ�...	
	BRNE	RET1		;0�� �ƴϸ� RET1���� �б�.
	CBI	PORTA,2		
RET1:	RET
	
;----------- ���ū ���� �Լ�  --------------------------------------- 

BLINE:	CALL	FREE		
	
	CALL	TX0_STRING	;���׺�� ���ڿ� ����Լ� ȣ��.	
        .db     "---broken LINE--- ",0x0D,0x0A,0,0	;���׺����.
        
	CALL	D500MS	;���������� �߶�	
	SBI 	PORTA,0	;�ַ����̵� �۵�	
	CALL	D5SEC		;����
	CBI	PORTA,0	;�ַ����̵� ����
	
	CALL	D5SEC   	    
	 			
	JMP	START2		
	
;------------ ���� ��߳��� �� ���� �޼��� ���� �Լ�  -------------------

DANGER:SBIS	PINE,2	       ;5���� ���� ������ ������� ��ŵ.
	CBI	PORTE,7	;��� �� ���� ��Ȯ�� ���߸� �÷��� Ŭ�����.
	
	SBIS	PINE,3		;1���� ���� ������ ������� ��ŵ.
	CBI	PORTE,7
	
	SBIS	PINE,4		;2���� ���� ������ ������� ��ŵ.
	CBI	PORTE,7
	
	SBIS	PINE,5		;3���� ���� ������ ������� ��ŵ.
	CBI	PORTE,7
	
	SBIS	PINE,6		;4���� ���� ������ ������� ��ŵ.
	CBI	PORTE,7      
       SBIS	PORTE,7	;(PORT�� ���� �� ����)�÷��װ� Ŭ���� �ȵ����� ���׺� ���.
	RET
		
	CALL	TX0_STRING	;���׺�� ���ڿ� ����Լ� ȣ��.	
        .db     "DANGER !! ",0x0D,0x0A,0,0	;���׺����.
        CALL	D500MS	;0.5�� ���� ���.
        RET

;----------- �� ����  �Լ��� ----------------------------------------

UP:	LDI	R18,0X75	;���� ���� �Լ�,
UPP:	LDI	AL,0B11110001	;���� ��߻� ����.
	CALL	MOTOR	;������� �Լ� ȣ��.
	
	LDI	AL,0B11110010	;���� ��߻� ����.
	CALL	MOTOR
	
	LDI	AL,0B11110100	;���� ��߻� ����.
	CALL	MOTOR
	
	LDI	AL,0B11111000	;���� ��߻� ����.
	CALL	MOTOR
	DEC	R18		
	BRNE	UPP		
	RET			;ȣ���Ѱ����� ����.	
	
;----------- �ٿ� ����  �Լ��� ------------------------------	

DOWN:	LDI	R18,0X75	;�������� �Լ�.
DN2:	LDI	AL,0B11111000	;���� ��߻� ����.
	CALL	MOTOR			 
	
	LDI	AL,0B11110100	;���� ��߻� ����.
	CALL	MOTOR
	
	LDI	AL,0B11110010	;���� ��߻� ����.
	CALL	MOTOR
	
	LDI	AL,0B11110001	;���� ��߻� ����.
	CALL	MOTOR
	DEC	R18		
	BRNE	DN2	
	RET			;ȣ���Ѱ����� ����.
	
MOTOR:OUT	PORTD,AL	;���� ��� �Լ�.
	CALL	D5MS		
	RET

FREE:	LDI	AL,0B11110000		 
	OUT	PORTD,AL
	RET
	
DISP1: LDI	AL,0B00000110	  ;FND-1 DISP 
       JMP	OUTP
        
DISP2: LDI    AL,0B01011011  ;FND-2 DISP 
     	JMP	OUTP
        
DISP3: LDI    AL,0B01001111  ;FND-3 DISP   
    	JMP	OUTP
        
DISP4: LDI    AL,0B01100110  ;FND-4 DISP
	JMP	OUTP 
              
DISP5: LDI    AL,0B01101101  ;FND-5 DISP 
OUTP:	OUT	PORTB,AL    
       RET