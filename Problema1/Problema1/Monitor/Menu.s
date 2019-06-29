.data
.global main

#USA r2 PRA ARMAZENAR O ESTADO ATUAL
.equ menu_led1, 0x01
.equ menu_led2, 0x02
.equ menu_led3, 0x03
.equ menu_led4, 0x04
.equ menu_led5, 0x05
.equ ativo_led1, 0x06
.equ ativo_led2, 0x07
.equ ativo_led3, 0x08
.equ ativo_led4, 0x09
.equ ativo_led5, 0x0a

.equ botoes, 0x0840
.equ mled_coluna, 0x0850
.equ mled_linha, 0x0830

.equ btn_sobe, 0001
.equ btn_desce, 0010
.equ btn_seleciona, 0100
.equ btn_volta, 1000

#USA r10 LETRAS
.equ L, 0x4C
.equ E, 0x45
.equ D, 0x44
.equ d1, 0x31
.equ d2, 0x32
.equ d3, 0x33
.equ d4, 0x34
.equ d5, 0x35
.equ A, 0x41
.equ C, 0x43
.equ S, 0x53
.equ O, 0x4F
.equ espaco, 0x20

.text
#USA r3 PRA RETORNO DO MODULO
#USA r4 PRA BOTOES
#USA r5 PRA VALOR 1

main:
	movi r5, 1
	movia r4, botoes 	#r4 tem a posição inicial dos botões na memória
	movia r2, menu_led1 	#r2 guarda o estado atual
	call lcd_init
	br menu1

menu1:
	#botão sobe
	movia r12, btn_sobe
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	#botão desce
	movia r12, btn_desce
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	#botão select
	movia r12, btn_seleciona
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, led1
	
	beq r13, r5, menu1
	addi r13, r0, 1
	call limpa

	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, d1
	custom 0, r3, r5, r10
	br menu1

menu2:
	#botão sobe	
	movia r12, btn_sobe
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	#botão desce
	movia r12, btn_desce
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	#botão select
	movia r12, btn_seleciona
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, led2

	beq r14, r5, menu2
	addi r14, r0, 1
	call limpa
	
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, d2
	custom 0, r3, r5, r10
	br menu2

menu3:
	#botão sobe	
	movia r12, btn_sobe
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	#botão desce
	movia r12, btn_desce
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	#botão select
	movia r12, btn_seleciona
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, led3

	beq r15, r5, menu3
	addi r15, r0, 1
	call limpa
	
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, d3
	custom 0, r3, r5, r10
	br menu3

menu4:
	#botão sobe	
	movia r12, btn_sobe
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	#botão desce
	movia r12, btn_desce
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	#botão select
	movia r12, btn_seleciona
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, led4

	beq r16, r5, menu4
	addi r16, r0, 1
	call limpa
	
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, d4
	custom 0, r3, r5, r10

	br menu4

menu5:
	#botão sobe	
	movia r12, btn_sobe
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	#botão desce
	movia r12, btn_desce
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	#botão select
	movia r12, btn_seleciona
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, led5

	beq r17, r5, menu5
	addi r17, r0, 1
	call limpa
	
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, d5
	custom 0, r3, r5, r10
	br menu5

led1:
	call limpa

	movia r10, A
	custom 0, r3, r5, r10

	movia r10, C
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, S
	custom 0, r3, r5, r10
	
	movia r10, O
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, L
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, D
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, d1
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 01111
	stbio r7, 0(r6)

	#botão back
	movia r12, btn_volta
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	br led1

led2:
	call limpa
	
	movia r10, A
	custom 0, r3, r5, r10

	movia r10, C
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, S
	custom 0, r3, r5, r10
	
	movia r10, O
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, L
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, D
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, d2
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 10111
	stbio r7, 0(r6)

	#botão back
	movia r12, btn_volta
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	br led2

led3:
	call limpa
	
	movia r10, A
	custom 0, r3, r5, r10

	movia r10, C
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, S
	custom 0, r3, r5, r10
	
	movia r10, O
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, L
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, D
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, d3
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 11011
	stbio r7, 0(r6)

	#botão back
	movia r12, btn_volta
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	br led3

led4:
	call limpa
	
	movia r10, A
	custom 0, r3, r5, r10

	movia r10, C
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, S
	custom 0, r3, r5, r10
	
	movia r10, O
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, L
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, D
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, d4
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 11101
	stbio r7, 0(r6)

	#botão back
	movia r12, btn_volta
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	br led4

led5:
	call limpa
	
	movia r10, A
	custom 0, r3, r5, r10

	movia r10, C
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, S
	custom 0, r3, r5, r10
	
	movia r10, O
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, L
	custom 0, r3, r5, r10
	
	movia r10, E
	custom 0, r3, r5, r10
	
	movia r10, D
	custom 0, r3, r5, r10
	
	movia r10, espaco
	custom 0, r3, r5, r10
	
	movia r10, d5
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 11110
	stbio r7, 0(r6)

	#botão back
	movia r12, btn_volta
	ldbio r3, 0(r4)	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	br led5

limpa: #Limpa o display para uma nova escrita e a matriz de LED
	movi r11, 00000001 #Valor dos pinos para limpar o display
	custom 0, r10, r0, r11

	movia r6, mled_coluna
	movi r7, 31
	stbio r7, 0(r6) #Apaga todas as colunas

	movi r7, 255
	movia r6, mled_linha
	stbio r7, 0(r6) #Apaga todas as colunas

	ret
	
lcd_init:
	movia r3, 0x30 
	custom 0, r10, r0, r3
	movia r3, 0x30
	custom 0, r10, r0, r3
	movia r3, 0x39
	custom 0, r10, r0, r3
	movia r3, 0x14
	custom 0, r10, r0, r3
	movia r3, 0x56
	custom 0, r10, r0, r3
	movia r3, 0x6D
	custom 0, r10, r0, r3

	movia r3, 0x70
	custom 0, r10, r0, r3
	movia r3, 0x0C
	custom 0, r10, r0, r3
	movia r3, 0x06
	custom 0, r10, r0, r3
	movia r3, 0x01
	custom 0, r10, r0, r3

	ret

.end