;hien thi cac so 00..23 tren led7 thanh pack2
led  equ p2
q1   bit p3.0
q2   bit p3.1
q3   bit p3.2
q4   bit p3.3
q5   bit p3.4
q6   bit p3.5
q7   bit p3.6
q8   bit p3.7
	
so_ngay   equ 30h
so_thang  equ 31h
so_tk     equ 32h
so_nam    equ 33h

max   equ 34h

	
org 0
	
	mov p3,#00h  ; tat all qi=0
	
	mov so_ngay ,#26
	mov so_thang,#12
	mov so_tk   ,#20
	mov so_nam  ,#23
	
	MAIN:		
		acall display
		acall delay
		acall next_day
	JMP MAIN
	
	display:		
		mov DPTR, #maled
		mov  B,#10
		MOV  A,so_ngay
		DIV  AB
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q1  ; dv bat dau sang
		nop      ; dv van sang
		clr  q1  ; dv tat

		MOV  A,B
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		clr acc.7         ; bit dot =0 <=> SAN
		MOV  LED, A	  ; HIEN THI SO DV
		setb q2  ; dv bat dau sang
		nop      ; dv van sang
		clr  q2  ; dv tat

		mov  B,#10
		MOV  A,so_thang
		DIV  AB
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q3  ; dv bat dau sang
		nop      ; dv van sang
		clr  q3  ; dv tat

		MOV  A,B
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		clr acc.7         ; bit dot =0 <=> SAN
		MOV  LED, A	  ; HIEN THI SO DV
		setb q4  ; dv bat dau sang
		nop      ; dv van sang
		clr  q4  ; dv tat

		mov  B,#10
		MOV  A,so_tk
		DIV  AB
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q5  ; dv bat dau sang
		nop      ; dv van sang
		clr  q5  ; dv tat

		MOV  A,B
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q6  ; dv bat dau sang
		nop      ; dv van sang
		clr  q6  ; dv tat

		mov  B,#10
		MOV  A,so_nam
		DIV  AB
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q7  ; dv bat dau sang
		nop      ; dv van sang
		clr  q7  ; dv tat

		MOV  A,B
		MOVC A,@A+DPTR    ; LAY MA LED CUA DV
		MOV  LED, A	  ; HIEN THI SO DV
		setb q8  ; dv bat dau sang
		nop      ; dv van sang
		clr  q8  ; dv tat

ret
	
	next_day:		
		mov DPTR, #max_ngay
		mov A,so_thang
		movc A,@A+DPTR
		mov  max,A  ; max == ngay cuoi thang
		inc  max
		inc so_ngay  ; next ngay
		mov A, so_ngay
		cjne A,max,chua_qua_10
			mov so_ngay,#1
			inc so_thang   ; tang hang chuc
			mov A,so_thang
			cjne A,#13,chua_het_nam
				mov so_thang,#01
				inc so_nam
			chua_het_nam:
		chua_qua_10:
		
	ret
	
	DELAY:
		MOV R1,#20
		mov tmod,#01h
		lap:
			mov th0,#high(-50000)
			mov tl0,#low(-50000)
			setb tr0
			wait:
				acall display
			jnb  tf0, wait ; lenh nhay
			clr  tr0
			clr  tf0
		DJNZ R1,lap
	RET
	
	maled: db 11000000b,11111001b,10100100b,10110000b,10011001b,10010010b,10000010b,11111000b,10000000b,10010000b
	max_ngay: db 0,31,28,31,30,31,30,31,31,30,31,30,31
		   ;   1  2  3  4  5  6  7 8  9  10 11 12
end