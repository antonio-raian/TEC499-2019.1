.data
.global main
	.equ botoes, 0x2040
	.equ mled_coluna, 0x2050
	.equ mled_linha, 0x2030
	.equ uart, 0x2078

	.equ btn_sobe, 1
	.equ btn_desce, 2
	.equ btn_seleciona, 4
	.equ btn_volta, 8

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
	.equ igual, 0x3D
	.equ ponto, 0x2E
	.equ barra, 0x2F
	.equ underline, 0x5F
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
#USA r13 PARA TAMANHO DA MENSAGEM UART
#USA r14 PARA RETORNO DA CUSTOM

main:
	movi r5, 1
	movia r4, botoes 	#r4 tem a posição inicial dos botões na memória
	movia r9, uart
	call lcd_init
	call init_wifi_mode
	call connect_wifi
	call init_TCP_connection
	call mqtt_connect
	br menu1

menu1:
	#LIMPA O DISPLAY
	call limpa
	#ESCREVE "LED 1" NO DISPLAY
	movia r10, L
	custom 0, r14, r5, r10
	movia r10, E
	custom 0, r14, r5, r10
	movia r10, D
	custom 0, r14, r5, r10
	movia r10, espaco
	custom 0, r14, r5, r10
	movia r10, Um
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10
	movia r10, E
	custom 0, r14, r5, r10
	movia r10, D
	custom 0, r14, r5, r10
	movia r10, espaco
	custom 0, r14, r5, r10
	movia r10, Dois
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10
	movia r10, E
	custom 0, r14, r5, r10
	movia r10, D
	custom 0, r14, r5, r10
	movia r10, espaco
	custom 0, r14, r5, r10
	movia r10, Tres
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10
	movia r10, E
	custom 0, r14, r5, r10
	movia r10, D
	custom 0, r14, r5, r10
	movia r10, espaco
	custom 0, r14, r5, r10
	movia r10, Quatro
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10
	movia r10, E
	custom 0, r14, r5, r10
	movia r10, D
	custom 0, r14, r5, r10
	movia r10, espaco
	custom 0, r14, r5, r10
	movia r10, Cinco
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10

	movia r10, C
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, S
	custom 0, r14, r5, r10
	
	movia r10, O
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, L
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, D
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, Um
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10

	movia r10, C
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, S
	custom 0, r14, r5, r10
	
	movia r10, O
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, L
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, D
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, Dois
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10

	movia r10, C
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, S
	custom 0, r14, r5, r10
	
	movia r10, O
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, L
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, D
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, Tres
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10

	movia r10, C
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, S
	custom 0, r14, r5, r10
	
	movia r10, O
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, L
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, D
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, Quatro
	custom 0, r14, r5, r10

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
	custom 0, r14, r5, r10

	movia r10, C
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, S
	custom 0, r14, r5, r10
	
	movia r10, O
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, L
	custom 0, r14, r5, r10
	
	movia r10, E
	custom 0, r14, r5, r10
	
	movia r10, D
	custom 0, r14, r5, r10
	
	movia r10, espaco
	custom 0, r14, r5, r10
	
	movia r10, Cinco
	custom 0, r14, r5, r10

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
	custom 0, r14, r0, r11

	movia r6, mled_coluna
	movi r7, 31
	stbio r7, 0(r6) #Apaga todas as colunas

	movi r7, 255
	movia r6, mled_linha
	stbio r7, 0(r6) #Apaga todas as colunas

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

#Envia o dado presente em r3 para a UART
#r9 contém o endereço base da UART
uart_write:
	mov r10, r0
	ldwio r10, 4(r9)
	andhi r10, r10, 0x00ff
	beq r10, r0, uart_write
	stwio r3, 0(r9)

	#custom 0, r14, r5, r3 #escreve no lcd

	ret

mqtt_connect:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno

	movi r13, 17
	call esp_send
	mov r3, r0

	#MQTT PACKET

	#FIXED HEADER
	movia r3, 0x10 #CONNECT = 00010000
	call uart_write
	movia r3, 0x0F #REMAIN BYTES(15)  
	call uart_write
	
	#VARIABLE HEADER
	movia r3, 0x00 #Length MSB = 00000000 
	call uart_write
	movia r3, 0x04 #Length LSB = 00000100 (4)
	call uart_write
	movia r3, M    #Protocol Name
	call uart_write
	movia r3, Q
	call uart_write
	movia r3, T
	call uart_write
	movia r3, T
	call uart_write
	movia r3, 0x03 #Protocol Version Number (Version 3)
	call uart_write
	movia r3, 0x02 #Connect Flags = 00000010
	call uart_write 
	movia r3, 0x00 #Keep Alive Timer MSB (0)
	call uart_write
	movia r3, 0x3C #Keep Alive Timer LSB (60)
	call uart_write

	#PAYLOAD
	movia r3, 0x00 #Message Length MSB (0)
	call uart_write
	movia r3, 0x03 #Message Length LSB (3)
	call uart_write
	movia r3, G    #Client ID
	call uart_write
	movia r3, P
	call uart_write
	movia r3, Um
	call uart_write

	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

#Envia os dados de publicação do mqtt para a UART
#r12 deve conter o conteúdo da mensagem
mqtt_pub:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno

	movi r13, 14 #Tamanho do pacote MQTT(em bytes)
	call esp_send
	mov r3, r0

	#MQTT PACKET

	#FIXED HEADER
	movia r3, 0x30 #PUBLISH = 00110000
	call uart_write
	movia r3, 0x0C #REMAIN BYTES = 00001100
	call uart_write

	#VARIABLE HEADER
	movia r3, 0x00 #Length MSB = 00000000
	call uart_write
	movia r3, 0x07 #Length LSB = 00000111
	call uart_write
	movia r3, S    #Topic name = SDTopic
	call uart_write
	movia r3, D
	call uart_write
	movia r3, T
	call uart_write
	movia r3, o
	call uart_write
	movia r3, p
	call uart_write
	movia r3, i
	call uart_write
	movia r3, c
	call uart_write

	#PAYLOAD
	movia r3, 0x00 #Length MSB = 00000000
	call uart_write
	movia r3, 0x01 #Length LSB = 00000001
	call uart_write
	mov r3, r12    #Número que será enviado
	call uart_write

	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

#Inicia o ESP em modo wifi
init_wifi_mode:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno
	mov r3, r0

	#AT
	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	#AT+RST
	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, R
	call uart_write
	movia r3, S
	call uart_write
	movia r3, T
	call uart_write
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write


	#AT+CWMODE_CUR=1
	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, C
	call uart_write
	movia r3, W
	call uart_write
	movia r3, M
	call uart_write
	movia r3, O
	call uart_write
	movia r3, D
	call uart_write
	movia r3, E
	call uart_write
	movia r3, underline
	call uart_write
	movia r3, C
	call uart_write
	movia r3, U
	call uart_write
	movia r3, R
	call uart_write
	movia r3, igual
	call uart_write
	movia r3, Um
	call uart_write
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	#AT+CIPMUX=0
	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, C
	call uart_write
	movia r3, I
	call uart_write
	movia r3, P
	call uart_write
	movia r3, M
	call uart_write
	movia r3, U
	call uart_write
	movia r3, X
	call uart_write
	movia r3, igual
	call uart_write
	movia r3, Zero
	call uart_write
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

#Conecta à rede do broker
#Esse tem que ser feito no lab
connect_wifi:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno
	mov r3, r0

	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, C
	call uart_write
	movia r3, W
	call uart_write
	movia r3, J
	call uart_write
	movia r3, A
	call uart_write
	movia r3, P
	call uart_write
	movia r3, igual
	call uart_write
	movia r3, aspas
	call uart_write
	
	#SSID (WWWWWWWWW)
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write
	movia r3, W
	call uart_write


	movia r3, aspas
	call uart_write
	movia r3, virgula
	call uart_write
	movia r3, aspas
	call uart_write

	#SENHA (HelloWorldMP31)
	movia r3, H
	call uart_write
	movia r3, e
	call uart_write
	movia r3, l
	call uart_write
	movia r3, l
	call uart_write
	movia r3, o
	call uart_write
	movia r3, W
	call uart_write
	movia r3, o
	call uart_write
	movia r3, r
	call uart_write
	movia r3, l
	call uart_write
	movia r3, d
	call uart_write
	movia r3, M
	call uart_write
	movia r3, P
	call uart_write
	movia r3, Tres
	call uart_write
	movia r3, Um
	call uart_write
	movia r3, aspas
	call uart_write

	#/r/n para marcar o fim do comando AT
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

init_TCP_connection:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno
	mov r3, r0

	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, C
	call uart_write
	movia r3, I
	call uart_write
	movia r3, P
	call uart_write
	movia r3, S
	call uart_write
	movia r3, T
	call uart_write
	movia r3, A
	call uart_write
	movia r3, R
	call uart_write
	movia r3, T
	call uart_write
	movia r3, igual
	call uart_write
	movia r3, aspas
	call uart_write
	movia r3, T
	call uart_write
	movia r3, C
	call uart_write
	movia r3, P	
	call uart_write
	movia r3, aspas
	call uart_write
	movia r3, virgula
	call uart_write
	movia r3, aspas
	call uart_write

	#IP (192.168.43.200)
	movia r3, Um
	call uart_write
	movia r3, Nove
	call uart_write
	movia r3, Dois
	call uart_write
	movia r3, ponto
	call uart_write
	movia r3, Um
	call uart_write
	movia r3, Seis
	call uart_write
	movia r3, Oito
	call uart_write
	movia r3, ponto
	call uart_write
	movia r3, Quatro
	call uart_write
	movia r3, Tres
	call uart_write
	movia r3, ponto
	call uart_write
	movia r3, Dois
	call uart_write
	movia r3, Zero
	call uart_write
	movia r3, Zero
	call uart_write

	movia r3, aspas
	call uart_write
	movia r3, virgula
	call uart_write
	
	#PORTA (1883)
	movia r3, Um
	call uart_write
	movia r3, Oito
	call uart_write
	movia r3, Oito
	call uart_write
	movia r3, Tres
	call uart_write

	#/r/n para marcar o fim do comando AT
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

#Envia mensagens através do ESP
# r13 deve conter o tamanho em bytes da mensagem a ser enviada
esp_send:
	subi sp, sp, 4
	stw ra, 0(sp) #armazena o endereço de retorno
	mov r3, r0

	movia r3, A
	call uart_write
	movia r3, T
	call uart_write
	movia r3, mais
	call uart_write
	movia r3, C
	call uart_write
	movia r3, I
	call uart_write
	movia r3, P
	call uart_write
	movia r3, S
	call uart_write
	movia r3, E
	call uart_write
	movia r3, N
	call uart_write
	movia r3, D
	call uart_write
	movia r3, igual
	call uart_write
	mov r3, r13    #Tamanho da mensagem que será enviada (em bytes)
	call uart_write

	#/r/n para marcar o fim do comando AT
	movi r3, 13 # /r
	call uart_write
	movi r3, 10 # /n
	call uart_write

	ldw ra, 0(sp)
	addi sp, sp, 4
	ret

.end