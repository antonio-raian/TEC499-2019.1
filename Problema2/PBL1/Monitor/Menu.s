.data
.global main

.equ botoes, 0x0840
.equ mled_coluna, 0x0850
.equ mled_linha, 0x0830
.equ uart, 0x0868

.equ btn_sobe, 1
.equ btn_desce, 2
.equ btn_seleciona, 4
.equ btn_volta, 8

.equ L, 0x4C
.equ E, 0x45
.equ D, 0x44
.equ Um, 0x31
.equ Dois, 0x32
.equ Tres, 0x33
.equ Quatro, 0x34
.equ Cinco, 0x35
.equ A, 0x41
.equ C, 0x43
.equ S, 0x53
.equ O, 0x4F
.equ espaco, 0x20
.equ T, 0x45
.equ o, 0x6F
.equ p, 0x70
.equ i, 0x69
.equ c, 0x63


.text

# REGISTRADORES UTILIZADOS
#USA r2 PARA VERIFICAR SE OS BOTÕES FORAM PRESSIONADOS
#USA r3 PARA RETORNO DO MODULO
#USA r4 PARA A POSIÇÃO DE MEMÓRIA DOS BOTOES
#USA r5 PARA VALOR 1
#USA r8 PARA LOOP DE VERIFICAÇÃO DOS BOTÕES
#USA r9 PARA A POSIÇÃO DE MEMÓRIA DA UART
#USA r10 PARA LETRAS
#USA r12 PARA CONTEÚDO DA MENSAGEM MQTT

main:
	movi r5, 1
	movia r4, botoes 	#r4 tem a posição inicial dos botões na memória
	movia r9, uart
	call lcd_init
	br menu1

menu1:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 1" NO DISPLAY
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, Um
	custom 0, r3, r5, r10

	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)
	movia r2, btn_sobe 	#BOTÃO SOBE 	
	beq r2, r3, menu5
	
	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, menu2
	
	movia r2, btn_seleciona #BOTÃO SELECT
	beq r2, r3, led1
	callr r8

menu2:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 2" NO DISPLAY
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, Dois
	custom 0, r3, r5, r10

	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)
	
	movia r2, btn_sobe #BOTÃO SOBE	
	beq r2, r3, menu1
	
	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, menu3
	
	movia r2, btn_seleciona #BOTÃO SELECT
	beq r2, r3, led2
	callr r8

menu3:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 3" NO DISPLAY
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, Tres
	custom 0, r3, r5, r10

	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO	
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_sobe #BOTÃO SOBE	
	beq r2, r3, menu2

	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, menu4
	
	movia r2, btn_seleciona #BOTÃO SELECT
	beq r2, r3, led3
	callr r8

menu4:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 4" NO DISPLAY
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, Quatro
	custom 0, r3, r5, r10

	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO	
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_sobe #BOTÃO SOBE
	beq r2, r3, menu3

	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, menu5

	movia r2, btn_seleciona #BOTÃO SELECIONA
	beq r2, r3, led4
	callr r8

menu5:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 5" NO DISPLAY
	movia r10, L
	custom 0, r3, r5, r10
	movia r10, E
	custom 0, r3, r5, r10
	movia r10, D
	custom 0, r3, r5, r10
	movia r10, espaco
	custom 0, r3, r5, r10
	movia r10, Cinco
	custom 0, r3, r5, r10

	call delay
	#LOOP PARA VERIFICAR SE UM DOS BOTÕES FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)	
	movia r2, btn_sobe #BOTÃO SOBE
	beq r2, r3, menu4
	
	movia r2, btn_desce #BOTÃO DESCE
	beq r2, r3, menu1

	movia r2, btn_seleciona #BOTÃO SELECT
	beq r2, r3, led5
	callr r8

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
	
	movia r10, Um
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 30
	stbio r7, 0(r6)

	movia r12, Um
	call mqtt_pub

	call delay
	#LOOP PARA VERIFICAR SE O BOTÃO "VOLTA" FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_volta #BOTÃO VOLTA
	beq r2, r3, menu1
	callr r8

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
	
	movia r10, Dois
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 29
	stbio r7, 0(r6)

	movia r12, Dois
	call mqtt_pub

	call delay
	#LOOP PARA VERIFICAR SE O BOTÃO "VOLTA" FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_volta #BOTÃO VOLTA
	beq r2, r3, menu2
	callr r8

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
	
	movia r10, Tres
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 27
	stbio r7, 0(r6)

	movia r12, Tres
	call mqtt_pub

	call delay
	#LOOP PARA VERIFICAR SE O BOTÃO "VOLTA" FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_volta #BOTÃO VOLTA
	beq r2, r3, menu3
	callr r8

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
	
	movia r10, Quatro
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 23
	stbio r7, 0(r6)

	movia r12, Quatro
	call mqtt_pub

	call delay
	#LOOP PARA VERIFICAR SE O BOTÃO "VOLTA" FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_volta #BOTÃO VOLTA
	beq r2, r3, menu4
	callr r8

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
	
	movia r10, Cinco
	custom 0, r3, r5, r10

	movia r6, mled_coluna
	mov r7, r0
	stbio r7, 0(r6)

	movia r6, mled_linha
	movi r7, 15
	stbio r7, 0(r6)

	movia r12, Cinco
	call mqtt_pub

	call delay
	#LOOP PARA VERIFICAR SE O BOTÃO "VOLTA" FOI PRESSIONADO
	nextpc r8
	ldbuio r3, 0(r4)

	movia r2, btn_volta #BOTÃO VOLTA
	beq r2, r3, menu5
	callr r8

delay: #DELAY DE 10ms
	movia r7, 500000
wait:
	subi r7, r7, 1
	bne r7, r0, wait
	ret

limpa: #Limpa o display para uma nova escrita e apaga a matriz de LED
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

#Envia o dado presente em r3 para a UART
#r9 contém o endereço base da UART
escreve_uart:
	ldwio r10, 4(r9)
	andhi r10, r10, 0x00ff
	beq r10, r0, escreve_uart
	stwio r3, 0(r9)

	ret

#Envia os dados de publicação do mqtt para a UART
#r12 deve conter o conteúdo da mensagem
mqtt_pub:
	subi sp, sp, 8
	stbio ra, 0(sp) #armazena o endereço de retorno

	movia r3, 0x30 #PUBLISH = 00110000
	call escreve_uart
	movia r3, 0x09 #REMAIN BYTES = 00001001
	call escreve_uart
	mov r3, r0    #Length MSB = 00000000 (CONFERIR)
	call escreve_uart
	movia r3, 0x03 #Length LSB = 00000011 (CONFERIR)
	call escreve_uart
	movia r3, 0x2F # / = 00101111
	call escreve_uart
	movia r3, S
	call escreve_uart
	movia r3, D
	call escreve_uart
	movia r3, T
	call escreve_uart
	movia r3, o
	call escreve_uart
	movia r3, p
	call escreve_uart
	movia r3, i
	call escreve_uart
	movia r3, c
	call escreve_uart
	movia r3, r12
	call escreve_uart


	ldbio ra, 0(sp)
	addi sp, sp, 8
	ret

.end