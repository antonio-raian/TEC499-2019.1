.data
.global main
	.equ player1_endereco, 0x2030
	.equ player2_endereco, 0x2020

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
# r3 -> Endereço de memória do Player1
# r4 -> Endereço de memória do Player2
# r5 -> Auxiliar
# r6 -> Endereço para loops
# r7 -> Pontuação anterior do Player1
# r8 -> Pontuação anterior do Player2
# r9, r10 -> Parametro

main:
	movi r2, 1
	movia r3, player1_endereco
	movia r4, player2_endereco
	movia r7, Zero
	movia r8, Zero
	call lcd_init
	br write_scoreboard

write_scoreboard:
	#LIMPA O DISPLAY
	call clean
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
	
	movia r5, 0x8A
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x0A
	movia r5, Zero
	custom 0, r5, r2, r5 #Escreve a pontuação do player 1

	movia r5, 0xCA
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x4A
	movia r5, Zero
	custom 0, r5, r2, r5 #Escreve a pontuação do player 2

p1_scored:
	ldbuio r9, 0(r3) #Armazena a pontuação do P1 em r5
	bne r9, r7, player1
p2_scored:
	ldbuio r10, 0(r4) #Armazena a pontuação do P2 em r5
	bne r10, r8, player2
	br p1_scored


player1:
	movia r5, 0x8A
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x0A
	custom 0, r5, r2, r9 #Escreve a pontuação do player 1
	mov r7, r9			 #Atualiza r7
	br p2_scored

player2:
	movia r5, 0xCA
	custom 0, r5, r0, r5 #Move o cursor para a posição 0x4A
	custom 0, r5, r2, r10 #Escreve a pontuação do player 2
	mov r8, r10			 #Atualiza r8
	br p1_scored

clean: #Limpa o display para uma nova escrita
	movi r11, 00000001 #Valor dos pinos para limpar o display
	custom 0, r14, r0, r11
	ret
	
lcd_init:
	movia r5, 0x30 
	custom 0, r14, r0, r5
	movia r5, 0x30
	custom 0, r14, r0, r5
	movia r5, 0x39
	custom 0, r14, r0, r5
	movia r5, 0x14
	custom 0, r14, r0, r5
	movia r5, 0x56
	custom 0, r14, r0, r5
	movia r5, 0x6D
	custom 0, r14, r0, r5

	movia r5, 0x70
	custom 0, r14, r0, r5
	movia r5, 0x0C
	custom 0, r14, r0, r5
	movia r5, 0x06
	custom 0, r14, r0, r5
	movia r5, 0x01
	custom 0, r14, r0, r5

	ret
.end