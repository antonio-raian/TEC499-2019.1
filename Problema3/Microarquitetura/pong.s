.data
.global main
	.equ botoes, 0x2040
	.equ btn_sobe, 1
	.equ btn_desce, 2


	.equ A, 0x41
	.equ C, 0x43
	.equ D, 0x44
	.equ E, 0x45
	.equ G, 0x47
	.equ H, 0x48
	.equ I, 0x49
	.equ J, 0x4A
	.equ L, 0x4C
	.equ M, 0X4D
	.equ N, 0x4E
	.equ O, 0x4F
	.equ P, 0x50
	.equ Q, 0x51
	.equ R, 0x52
	.equ S, 0x53
	.equ T, 0x54
	.equ U, 0x55
	.equ W, 0x57
	.equ X, 0x58
	.equ Y, 0x59
	.equ Zero, 0x30
	.equ Um, 0x31
	.equ Dois, 0x32
	.equ Tres, 0x33
	.equ Quatro, 0x34
	.equ Cinco, 0x35
	.equ Seis, 0x36
	.equ Sete, 0x37
	.equ Oito, 0x38
	.equ Nove, 0x39
	.equ d, 0x64
	.equ e, 0x65
	.equ o, 0x6F
	.equ p, 0x70
	.equ i, 0x69
	.equ c, 0x63
	.equ l, 0x6C
	.equ n, 0x6E
	.equ r, 0x72
	.equ s, 0x73
	.equ espaco, 0x20
	.equ aspas, 0x22
	.equ mais, 0x2B
	.equ virgula, 0x2C
	.equ doisPontos, 0x3A
	.equ igual, 0x3D
	.equ ponto, 0x2E
	.equ barra, 0x2F
	.equ underline, 0x5F
.text

# REGISTRADORES UTILIZADOS
# r2 -> Sempre = 1
# r3 -> Pontuação do Player1
# r4 -> Pontuação do Player2
# r5 -> Auxiliar
# r6 -> Endereço para loops

main:
	movi r2, 1
	movia r3, Zero
	movia r4, Zero
	call lcd_init
	br write_scoreboard

write_scoreboard:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "PLAYER 1:" NO DISPLAY
	movia r5, P
	custom 0, r5, r2, r5
	movia r5, L
	custom 0, r5, r2, r5
	movia r5, A
	custom 0, r5, r2, r5
	movia r5, Y
	custom 0, r5, r2, r5
	movia r5, E
	custom 0, r5, r2, r5
	movia r5, R
	custom 0, r5, r2, r5
	movia r5, espaco
	custom 0, r5, r2, r5
	movia r5, Um
	custom 0, r5, r2, r5
	movia r5, doisPontos
	custom 0, r5, r2, r5

	movia r5, 0xC0 #Move o cursor para a posição 0x40
	custom 0, r5, r0, r5

	#ESCREVE "PLAYER 2:" NO DISPLAY
	movia r5, P
	custom 0, r5, r2, r5
	movia r5, L
	custom 0, r5, r2, r5
	movia r5, A
	custom 0, r5, r2, r5
	movia r5, Y
	custom 0, r5, r2, r5
	movia r5, E
	custom 0, r5, r2, r5
	movia r5, R
	custom 0, r5, r2, r5
	movia r5, espaco
	custom 0, r5, r2, r5
	movia r5, Dois
	custom 0, r5, r2, r5
	movia r5, doisPontos
	custom 0, r5, r2, r5

player1:
	movia r5, 0x4A
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x0A
	addi r3, r3, 1  #Incrementa 1 na pontuação do player 1
	custom 0, r5, r2, r3 #Escreve o novo valor na posição 
	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO
	nextpc r6
	ldbuio r3, 0(r4)
	movia r2, btn_sobe 	#BOTÃO SOBE 	
	beq r2, r3, player1
	
	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, player2
	callr r6

player2:
	movia r5, 0xCA
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x4A
	addi r4, r4, 1  #Incrementa 1 na pontuação do player 2
	custom 0, r5, r2, r4 #Escreve o novo valor na posição 
	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO
	nextpc r6
	ldbuio r3, 0(r4)
	movia r2, btn_sobe 	#BOTÃO SOBE 	
	beq r2, r3, player1
	
	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, player2
	callr r6

delay: #DELAY DE 10ms
	movia r7, 500000
wait:
	subi r7, r7, 1
	bne r7, r0, wait
	ret

clean: #Limpa o display para uma nova escrita
	movi r11, 00000001 #Valor dos pinos para limpar o display
	custom 0, r14, r0, r11
	ret
	
lcd_init:
	movia r3, 0x30 
	custom 0, r14, r0, r3
	movia r3, 0x30
	custom 0, r14, r0, r3
	movia r3, 0x39
	custom 0, r14, r0, r3
	movia r3, 0x14
	custom 0, r14, r0, r3
	movia r3, 0x56
	custom 0, r14, r0, r3
	movia r3, 0x6D
	custom 0, r14, r0, r3

	movia r3, 0x70
	custom 0, r14, r0, r3
	movia r3, 0x0C
	custom 0, r14, r0, r3
	movia r3, 0x06
	custom 0, r14, r0, r3
	movia r3, 0x01
	custom 0, r14, r0, r3

	ret

.end