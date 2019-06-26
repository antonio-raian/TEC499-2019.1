.data

.global main

.text

main:
	#botão desce
	movi r4, 50 	#r4 tem a posição 50 da memória
	ldw r3, 0[r4]	#r3 tem o valor q está na memória de r4
	bne r3, r0, desce
	#botão sobe
	ldw r5, 4[r4]	#r3 tem o valor q está na memória de r4
	bne r5, r0, sobe
	br main
desce:
	
sobe:

seleciona:

volta:

.end