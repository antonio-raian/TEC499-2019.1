.data
#--------------Mapeamento do LCD --------------------
	v0: #pino V10
	rs: #pino U9
	rw: #pino U8
	en: #pino V9
	dados: #V8, V7, V6, V5, V4, Y4, V3, Y3

.global main

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

.equ botoes, 0x2030

.text

main:
	movi v0, 1
	movi r4, botoes 	#r4 tem a posição inicial dos botões na memória
	movi r10, 200
	movi r2, menu_led1 #r2 guarda o estado atual
	call lcd_init
	mov r11, r2
	movi r10, 1
	custom 0, r10, r10, r11 #Escreve no display o estado inicial
	br menu1
	br end

menu1:
	call limpa
	movi r2, menu_led1
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	ldw r3, 0[r4]	#r3 tem o valor q está na memória de r4
	bne r3, r0, menu5
	#botão desce
	ldw r3, 4[r4]
	bne r3, r0, menu2
	#botão select
	ldw r3, 8[r4]
	bne r3, r0, led1
	br menu1

menu2:
	call limpa
	movi r2, menu_led2
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	ldw r3, 0[r4]
	bne r3, r0, menu1
	#botão desce
	ldw r3, 4[r4]
	bne r3, r0, menu3
	#botão select
	ldw r3, 8[r4]
	bne r3, r0, led2
	br menu2

menu3:
	call limpa
	movi r2, menu_led3
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	ldw r3, 0[r4]
	bne r3, r0, menu2
	#botão desce
	ldw r3, 4[r4]
	bne r3, r0, menu4
	#botão select
	ldw r3, 8[r4]
	bne r3, r0, led3
	br menu3

menu4:
	call limpa
	movi r2, menu_led4
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	ldw r3, 0[r4]
	bne r3, r0, menu3
	#botão desce
	ldw r3, 4[r4]
	bne r3, r0, menu5
	#botão select
	ldw r3, 8[r4]
	bne r3, r0, led4
	br menu4

menu5:
	call limpa
	movi r2, menu_led5
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	ldw r3, 0[r4]
	bne r3, r0, menu4
	#botão desce
	ldw r3, 4[r4]
	bne r3, r0, menu1
	#botão select
	ldw r3, 8[r4]
	bne r3, r0, led5
	br menu5

led1:
	call limpa
	movi r2, ativo_led1
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED1"
	#botão back
	ldw r3, 12[r4]
	bne r3, r0, menu1
	br led1

led2:
	call limpa
	movi r2, ativo_led2
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED2"
	#botão back
	ldw r3, 12[r4]
	bne r3, r0, menu2
	br led2

led3:
	call limpa
	movi r2, ativo_led3
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED3"
	#botão back
	ldw r3, 12[r4]
	bne r3, r0, menu3
	br led3

led4:
	call limpa
	movi r2, ativo_led4
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED4"
	#botão back
	ldw r3, 12[r4]
	bne r3, r0, menu4
	br led4

led5:
	call limpa
	movi r2, ativo_led5
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED5"
	#botão back
	ldw r3, 12[r4]
	bne r3, r0, menu5
	br led5

limpa: #Limpa o display para uma nova escrita
	movi r11, 0001 #Valor dos pinos para limpar o display (CORRIGIR)
	custom 0, r10, r0, r11
	ret
	
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