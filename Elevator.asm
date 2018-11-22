.nolist
.include "m128def.inc"	 ; ATmega128 definition file
.list

.cseg	.org	0x0000

START:LDI	AH,high(RAMEND)		 
	LDI	AL,low(RAMEND)
	OUT	SPH,AH
	OUT	SPL,AL

	CALL	INIT_MCU		;메가 128의 각 포트를 선언 함
	CALL	INIT_COM		;시리얼포트 초기화 함수 호출.	

START2:		
;********** 메인 프로그램 *********************************************

MAIN:	CALL	DISP1		;첫 시작은  1층부터.

;---------1층-------------------------------------------------------

F1:	CALL	PUSHS		;버튼 함수 호출.	
	CBI	PORTC,3	;1층LED는 소등
	CALL	FLAG		;타 층 플래그 유무 체크.
	SBIS	PORTA,2	;버튼누름 플래그 체크해서 있으면 스킵...
	JMP	F1		;없으면 F1로 분기. 
	
	CALL	D10MS
	DEC	R20		;타이머 감소.		
	BRNE	F1		
	
;--------- 2층 -----------------------------------------------------	
UP2:	CALL	UP		;상승.
	CALL	DISP2		;2층  
	SBIS	PORTC,4	;2층 플래그 셋트 이면 스킵. 	
	JMP	UP3		;아니면 3층으로 출발.
			
F2:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.
	
	CALL	PUSHS 	;2층에 멈춰서 층 누름 및 음성함수호출.
	CBI	PORTC,4	;2층LED는 소등.	
	CALL	FLAG		;타 층 플래그 유무 체크.
	SBIS	PORTA,2	;버튼누름 플래그 체크해서 있으면 스킵 ...
	JMP	F2		;없으면 F2로 분기. 
	
	CALL	D10MS
	DEC	R20		;타이머 감소.
	BRNE	F2		
	
	SBIC	PORTC,7	;5층?  
	JMP	UP3
	SBIC	PORTC,6	;4층?
	JMP	UP3
	SBIC	PORTC,5	;3층?.
	JMP	UP3
	SBIC	PORTC,3	;1층?  
	JMP	DOWN1

;--------------3층------------------------------------------------

UP3:	CALL	UP		;상승.
	CALL	DISP3		;3층  
	SBIS	PORTC,5	;3층 플래그 셋트 이면 스킵. 	
	JMP	UP4		;아니면 4층으로 출발.
	
F3:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.
	
	CALL	PUSHS 
	CBI	PORTC,5	;3층LED는 소등. 
	CALL	FLAG		;각층 플래그 유무 체크.
	SBIS	PORTA,2	;누름 플래그 체크해서...
	JMP	F3		;없으면 F3 로 분기. 
	
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

;----------- 4층 ---------------------------------------------------

UP4:	CALL	UP
	CALL	DISP4		;4층  
	SBIS	PORTC,6	;4층 플래그 셋트 이면 스킵. 	
	JMP	UP5
	
F4:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.
	
	CALL	PUSHS 
	CBI	PORTC,6	;4층LED는 소등. 
	CALL	FLAG		;각층 플래그 유무 체크.
	SBIS	PORTA,2	;누름 플래그 체크해서...
	JMP	F4		;없으면 F4로 분기.(무한반복)
	
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
 
;------------ 5층 ------------------------------------------------

UP5:	CALL	UP
	CALL	DISP5		;5		
		
F5:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.
	
	CALL	PUSHS 
	CBI	PORTC,7	;5 LED는 소등. 
	CALL	FLAG		;각층 플래그 유무 체크.
	SBIS	PORTA,2	;누름 플래그 체크해서...
	JMP	F5		;없으면 F5 로 분기. 
	
	CALL	D10MS
	DEC	R20		
	BRNE	F5		
	 
;--------------------4층  ------------------------------------------

DOWN4:CALL	DOWN
	CALL	DISP4
	SBIS	PORTC,6	;4층 플래그?
	JMP	DOWN3
	
FD4:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.

	CALL	PUSHS	
	CBI	PORTC,6	;해당 층LED는 소등
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD4		;없으면 FD4로 분기. 
	
	CALL	D10MS
	DEC	R20		;타이머 감소.
	BRNE	FD4		
	
	SBIC	PORTC,3	;1?
	JMP	DOWN3
	SBIC	PORTC,4	;2?
	JMP	DOWN3
	SBIC	PORTC,5	;3?
	JMP	DOWN3
	SBIC	PORTC,7	;5?
	JMP	UP5	

;---------------- 3층 ---------------------------------------------

DOWN3:CALL	DOWN
	CALL	DISP3
	SBIS	PORTC,5	;3층 플래그?
	JMP	DOWN2		

FD3:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.

	CALL	PUSHS	
	CBI	PORTC,5	;3층LED는 소등
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD3		;없으면 FD3 분기. 
	
	CALL	D10MS
	DEC	R20		;타이머 감소.
	BRNE	FD3		
	
	SBIC	PORTC,3	;1?
	JMP	DOWN2
	SBIC	PORTC,4	;2?
	JMP	DOWN2
	SBIC	PORTC,6	;4?
	JMP	UP4
	SBIC	PORTC,7	;5?
	JMP	UP4	
		
;--------------------- 2층 -----------------------------------------

DOWN2:CALL	DOWN
	CALL	DISP2
	SBIS	PORTC,4	;2층 플래그? 
	JMP	DOWN1

FD2:	SBIS	PINA,1		;끊음 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	BLINE		;누르면 스킵 못하고 BLINE로 분기.

	CALL	PUSHS	
	CBI	PORTC,4	;2 LED는 소등
	CALL	FLAG
	SBIS	PORTA,2
	JMP	FD2		;없으면 FD2 분기. 
	
	CALL	D10MS
	DEC	R20		;타이머 감소.
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
	JMP	MAIN		;처음으로 돌아감.
	
;************* 메인 끝 ***************************************************
;-----------음성함수  ----------------------------------------------- 

VOICE:	IN	AL,PINC	;음성 출력을 읽어 와서......	
	CPI	AL,0B00000110	;1인가를 비교해서...
	BRNE	NEXT1		;아니면 NEXT1로 브렌치함.
	JMP	SW1
	
NEXT1:CPI	AL,0B00000101	;2 인가.
	BRNE	NEXT2		 
	JMP	SW2
	
NEXT2:CPI	AL,0B00000100	;3인가
	BRNE	NEXT3
	JMP	SW3
	
NEXT3:CPI	AL,0B00000011	;4인가?
	BRNE	NEXT4
	JMP	SW4
	
NEXT4:CPI	AL,0B00000010	;5 인가?
	BRNE	NEXT5
	JMP	SW5	
NEXT5:RET	

;----------- 버튼누름함수  -------------------------------------------

PUSHS:CALL	DANGER	;엘베가 각층에 정확히 멈췄는지 체크. 

PUSHSS:CALL	VOICE		  
 
	SBIS	PINA,3		;1 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	SW1		
 	SBIS	PINA,4		;2 스위치를 누르지 않으면 다음 명령 스킵.
	JMP	SW2		
	SBIS	PINA,5		;3 스위치 ?
	JMP	SW3		
	SBIS	PINA,6		;4 스위치 ?
	JMP	SW4		
	SBIS	PINA,7		;5 스위치 ?
	JMP	SW5	
	RET			
	
SW1:  SBI	PORTC,3	;1층 LED ON
	CALL	FLSW
	RET
SW2:  SBI	PORTC,4	;2층 LED ON
	CALL	FLSW
	RET
SW3:  SBI	PORTC,5	;3층 LED ON
	CALL	FLSW
	RET
SW4:  SBI	PORTC,6	;4층 LED ON
	CALL	FLSW
	RET
SW5:  SBI	PORTC,7	;5층 LED ON
	CALL	FLSW
	RET
	
FLSW:	SBI	PORTA,2		
	RET

FLAG:	IN	AH,PORTC		
	CPI	AH,0B00000000	;0인가를 비교해서...	
	BRNE	RET1		;0이 아니면 RET1으로 분기.
	CBI	PORTA,2		
RET1:	RET
	
;----------- 브로큰 라인 함수  --------------------------------------- 

BLINE:	CALL	FREE		
	
	CALL	TX0_STRING	;지그비로 문자열 출력함수 호출.	
        .db     "---broken LINE--- ",0x0D,0x0A,0,0	;지그비출력.
        
	CALL	D500MS	;엘리베이터 추락	
	SBI 	PORTA,0	;솔레노이드 작동	
	CALL	D5SEC		;유지
	CBI	PORTA,0	;솔레노이드 해제
	
	CALL	D5SEC   	    
	 			
	JMP	START2		
	
;------------ 층이 어긋났을 시 위험 메세지 전송 함수  -------------------

DANGER:SBIS	PINE,2	       ;5층에 엘베 없으면 다음명령 스킵.
	CBI	PORTE,7	;어느 한 층에 정확히 멈추면 플래그 클리어됨.
	
	SBIS	PINE,3		;1층에 엘베 없으면 다음명령 스킵.
	CBI	PORTE,7
	
	SBIS	PINE,4		;2층에 엘베 없으면 다음명령 스킵.
	CBI	PORTE,7
	
	SBIS	PINE,5		;3층에 엘베 없으면 다음명령 스킵.
	CBI	PORTE,7
	
	SBIS	PINE,6		;4층에 엘베 없으면 다음명령 스킵.
	CBI	PORTE,7      
       SBIS	PORTE,7	;(PORT로 했을 때 정상)플래그가 클리어 안됐으면 지그비 출력.
	RET
		
	CALL	TX0_STRING	;지그비로 문자열 출력함수 호출.	
        .db     "DANGER !! ",0x0D,0x0A,0,0	;지그비출력.
        CALL	D500MS	;0.5초 간격 출력.
        RET

;----------- 업 동작  함수임 ----------------------------------------

UP:	LDI	R18,0X75	;오름 동작 함수,
UPP:	LDI	AL,0B11110001	;모터 상발생 정보.
	CALL	MOTOR	;모터출력 함수 호출.
	
	LDI	AL,0B11110010	;모터 상발생 정보.
	CALL	MOTOR
	
	LDI	AL,0B11110100	;모터 상발생 정보.
	CALL	MOTOR
	
	LDI	AL,0B11111000	;모터 상발생 정보.
	CALL	MOTOR
	DEC	R18		
	BRNE	UPP		
	RET			;호출한곳으로 복귀.	
	
;----------- 다운 동작  함수임 ------------------------------	

DOWN:	LDI	R18,0X75	;내림동작 함수.
DN2:	LDI	AL,0B11111000	;모터 상발생 정보.
	CALL	MOTOR			 
	
	LDI	AL,0B11110100	;모터 상발생 정보.
	CALL	MOTOR
	
	LDI	AL,0B11110010	;모터 상발생 정보.
	CALL	MOTOR
	
	LDI	AL,0B11110001	;모터 상발생 정보.
	CALL	MOTOR
	DEC	R18		
	BRNE	DN2	
	RET			;호출한곳으로 복귀.
	
MOTOR:OUT	PORTD,AL	;모터 출력 함수.
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