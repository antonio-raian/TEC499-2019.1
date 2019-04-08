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
	
lcd_init:
	movi r3, 00111100
	call config
	movi r3, 00001110
	call config
	movi r3, 00000001
	call config
	movi r3, 00000111
	call config

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
	movi r8, 50
wait:
	subi r8, r8, 1
	bne r8, r0, wait
	ret
end: