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

.equ botoes, 0x2030

.equ btn_sobe, 0001
.equ btn_desce, 0010
.equ btn_seleciona, 0100
.equ btn_volta, 1000

#USA r10 LETRAS
.equ L, 0x4c
.equ E, 0x45
.equ D, 0x44
.equ 1, 00110001
.equ 2, 00110010
.equ 3, 00110011
.equ 4, 00110100
.equ 5, 00110101
.equ A, 0x41
.equ C, 0x43
.equ S, 0x53
.equ O, 0x4f
.equ espaco, 0x20

.text
#USA r3 PRA RETORNO DO MODULO
#USA r4 PRA BOTOES
#USA r5 PRA VALOR 1

main:
	movi r5, 1
	movi r4, botoes 	#r4 tem a posição inicial dos botões na memória
	movi r2, menu_led1 	#r2 guarda o estado atual
	call lcd_init
	br menu1
	br end

menu1:
	call limpa

	movi r10, L
	custom 0, r3, r0, r10
	call delay_50us
	movi r10, E
	custom 0, r3, r0, r10
	call delay_50us
	movi r10, D
	custom 0, r3, r0, r10
	call delay_50us
	movi r10, espaco
	custom 0, r3, r0, r10
	call delay_50us
	movi r10, 1
	custom 0, r3, r0, r10
	call delay_50us
	
	#botão sobe
	movi r12, btn_sobe
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	#botão desce
	movi r12, btn_desce
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	#botão select
	movi r12, btn_seleciona
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, led1
	br menu1

menu2:
	call limpa
	movi r2, menu_led2
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	movi r12, btn_sobe
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	#botão desce
	movi r12, btn_desce
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	#botão select
	movi r12, btn_seleciona
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, led2
	br menu2

menu3:
	call limpa
	movi r2, menu_led3
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	movi r12, btn_sobe
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	#botão desce
	movi r12, btn_desce
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	#botão select
	movi r12, btn_seleciona
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, led3

menu4:
	call limpa
	movi r2, menu_led4
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	movi r12, btn_sobe
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	#botão desce
	movi r12, btn_desce
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	#botão select
	movi r12, btn_seleciona
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, led4
	br menu4

menu5:
	call limpa
	movi r2, menu_led5
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11
	#botão sobe	
	movi r12, btn_sobe
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	#botão desce
	movi r12, btn_desce
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	#botão select
	movi r12, btn_seleciona
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, led5
	br menu5

led1:
	call limpa

	movi r10, A
	custom 0, r3, r0, r10
	call delay_50us

	movi r10, C
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, E
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, S
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, O
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, espaco
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, L
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, E
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, D
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, espaco
	custom 0, r3, r0, r10
	call delay_50us
	
	movi r10, 1
	custom 0, r3, r0, r10
	call delay_50us

	#botão back
	movi r12, btn_volta
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu1
	br led1

led2:
	call limpa
	movi r2, ativo_led2
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED2"
	#botão back
	movi r12, btn_volta
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu2
	br led2

led3:
	call limpa
	movi r2, ativo_led3
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED3"
	#botão back
	movi r12, btn_volta
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu3
	br led3

led4:
	call limpa
	movi r2, ativo_led4
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED4"
	#botão back
	movi r12, btn_volta
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu4
	br led4

led5:
	call limpa
	movi r2, ativo_led5
	movi r10, 1
	movi r11, r2
	custom 0, r10, r10, r11 #Envia o dado para acender os LEDs e exibir no LCD "ACENDENDO LED5"
	#botão back
	movi r12, btn_volta
	ldbio r3, 0[r4]	#r3 tem o valor q está na memória de r4
	beq r12, r3, menu5
	br led5

limpa: #Limpa o display para uma nova escrita
	movi r11, 00000001 #Valor dos pinos para limpar o display
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
	custom 0, r10, r0, r3
	call delay_50us
	ret

delay_50us:
	movi r9, 50
wait:
	subi r9, r9, 1
	bne r9, r0, wait
	ret
end: