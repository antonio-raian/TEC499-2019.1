.data
#--------------Mapeamento do LCD --------------------
	v0: #pino V10
	rs: #pino U9
	rw: #pino U8
	en: #pino V9
	dados: #V8, V7, V6, V5, V4, Y4, V3, Y3
	
.global main
.text

main:
	movi v0, 1
	movi r4, 50 	#r4 tem a posição 50 da memória
	movi r10, 200
	call lcd_init
	call loop
	br end

loop:
	#botão desce	
	ldw r3, 0[r4]	#r3 tem o valor q está na memória de r4
	bne r3, r0, desce
	#botão sobe
	ldw r5, 4[r4]	#r3 tem o valor q está na memória de r4
	bne r5, r0, sobe
	#botão select
	ldw r6, 8[r4]
	bne r6, r0, select
	#botão back
	ldw r7, 12[r4]
	bne r7, r0, back
	br loop
desce:
	movi r8, 0100
	stw r8, 0[r10]
	movi r8, 0
	br loop

sobe:
	movi r8, 1000
	custom 0, r2, r0, r8 #Manda pro modulo o valor q estiver no r8 para a segunda entrada
	movi r8, 0
	br loop

select:
	movi r8, 0010
	stw r8, 0[r10]
	movi r8, 0
	br loop

back:
	movi r8, 0001
	stw r8, 0[r10]
	movi r8, 0
	br loop
	
lcd_init:
	movi r3, 00111100 
	call config
	movi r3, 00001110 
	call config
	movi r3, 00000001
	call config
	movi r3, 00000111
	call config
	ret

config:
	movi rs, 0
	movi rw, 0
	movi en, 0
	call delay_50us
	movi en, 1
	call delay_50us
	mov dados, r3	
	call delay_50us
	movi en, 0
	call delay_50us
	ret

delay_50us:
	movi r9, 50
wait:
	subi r9, r9, 1
	bne r9, r0, wait
	ret
end: